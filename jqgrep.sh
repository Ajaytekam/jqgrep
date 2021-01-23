function jqgrep {
    case "$1" in
        ## configuration for ffuf
        "ffuf")
            ## ffuf patterns 
            case "$2" in
                1)
                    if [[ ! -z "$3" && -f "$3" ]]
                    then
                        jq '.results[]|select(.status==200)|"\(.url) [\(.status)]"' $3
                    elif [ -z "$3" ]
                    then
                        echo -e "Prints urls with status code 200 in \"url [status]\" format.\n"
                        echo -e '\t.results[]|select(.status==200)|"\(.url) [\(.status)]"\n'
                    elif [ ! -f "$3" ]
                    then
                        echo "[!] Json file \"${3}\" is not found on current working directory!!"
                    fi
                    ;;
                2)
                    if [[ ! -z "$3" && -f "$3" ]]
                    then
                        jq '.results[]|select(.status==200),select(.status==300),select(.status==301),select(.status==302)|"\(.url) [\(.status)]"' $3
                    elif [ -z "$3" ]
                    then
                        echo -e "Prints urls with status code 200|300|301|302 in \"url [status]\" format.\n"
                        echo -e '\t.results[]|select(.status==200),select(.status==300),select(.status==301),select(.status==302)|"\(.url) [\(.status)]"\n'
                    elif [ ! -f "$3" ]
                    then
                        echo "[!] Json file \"${3}\" is not found on current working directory!!"
                    fi
                    ;;
                3)
                    if [[ ! -z "$3" && -f "$3" ]]
                    then
                        jq '.results[]|select(.status==300),select(.status==301),select(.status==302)|"\(.url)  [\(.status)]  \(.redirectlocation)"' $3
                    elif [ -z "$3" ]
                    then
                        echo -e "Prints urls with status code 300|301|302 in \"url [status] redirectLocation\" format.\n"
                        echo -e '\t.results[]|select(.status==300),select(.status==301),select(.status==302)|"\(.url)  [\(.status)]  \(.redirectlocation)"\n'
                    elif [ ! -f "$3" ]
                    then
                        echo "[!] Json file \"${3}\" is not found on current working directory!!"
                    fi
                    ;;
                *)
                    echo -e "Available Patterns:"
                    echo -e "1)\tPrints urls with status code 200 in \"url [status]\" format."
                    echo -e "2)\tPrints urls with status code 200|300|301|302 in \"url [status]\" format."
                    echo -e "3)\tPrints urls with status code 300|301|302 in \"url [status] redirectLocation\" format."
                    echo
                    ;;
            esac
            ;;  
        *)
            echo -e "Usage :\tjqgrep <pattern_name> <pattern_ID> <json_filename>\n"
            echo -e "Available Pattern_Names : ffuf"
            echo -e "For Patterns|pattern_ID type: 'jqgrep <pattern_name>'\n"
            ;;
    esac
}
