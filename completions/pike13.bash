#!/usr/bin/env bash
# Bash completion for pike13 CLI
# Installation:
#   Copy this file to /etc/bash_completion.d/ or source it in your ~/.bashrc:
#   source /path/to/pike13-cli/completions/pike13.bash

_pike13_completion() {
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Get the base command (pike13)
    base="${COMP_WORDS[0]}"
    
    # Top-level commands
    local commands="desk front account report help version"
    
    # Desk subcommands
    local desk_commands="people events event_occurrences bookings appointments visits invoices payments locations services staff plans notes custom_fields revenue_categories sales_taxes make_ups waitlist person_visits person_plans person_waitlist person_waivers forms_of_payment help"
    
    # Front subcommands
    local front_commands="people-me events-list event-occurrences-list services-list appointments-available locations-list business branding bookings-get bookings-create bookings-update bookings-delete person-visits person-plans person-waitlist person-waivers forms-of-payment-list forms-of-payment-get forms-of-payment-me forms-of-payment-create forms-of-payment-update forms-of-payment-delete help"
    
    # Account subcommands
    local account_commands="me businesses people password-reset help"
    
    # Report subcommands
    local report_commands="clients transactions enrollments monthly_metrics invoices event_occurrences event_occurrence_staff invoice_items invoice_item_transactions pays person_plans staff_members help"
    
    # Resource operations (used by most resources)
    local resource_ops="list ls get create update delete help"
    
    # Common options
    local format_opts="--format --compact --color"
    local common_opts="--help -h"
    
    # Handle completion based on position
    case "${COMP_CWORD}" in
        1)
            # Complete top-level commands
            COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
            return 0
            ;;
        2)
            # Complete subcommands based on namespace
            case "${prev}" in
                desk)
                    COMPREPLY=( $(compgen -W "${desk_commands}" -- ${cur}) )
                    return 0
                    ;;
                front)
                    COMPREPLY=( $(compgen -W "${front_commands}" -- ${cur}) )
                    return 0
                    ;;
                account)
                    COMPREPLY=( $(compgen -W "${account_commands}" -- ${cur}) )
                    return 0
                    ;;
                report)
                    COMPREPLY=( $(compgen -W "${report_commands}" -- ${cur}) )
                    return 0
                    ;;
            esac
            ;;
        3)
            # Complete resource operations for desk commands
            if [ "${COMP_WORDS[1]}" = "desk" ]; then
                case "${prev}" in
                    people|events|event_occurrences|locations|services|staff|plans|invoices|visits|notes|custom_fields|revenue_categories|sales_taxes|waitlist|forms_of_payment)
                        COMPREPLY=( $(compgen -W "${resource_ops}" -- ${cur}) )
                        return 0
                        ;;
                    bookings)
                        COMPREPLY=( $(compgen -W "get create update delete help" -- ${cur}) )
                        return 0
                        ;;
                    person_visits|person_plans|person_waitlist|person_waivers)
                        COMPREPLY=( $(compgen -W "list ls help" -- ${cur}) )
                        return 0
                        ;;
                    make_ups)
                        COMPREPLY=( $(compgen -W "reasons generate help" -- ${cur}) )
                        return 0
                        ;;
                    appointments|payments)
                        COMPREPLY=( $(compgen -W "available summary get configuration void help" -- ${cur}) )
                        return 0
                        ;;
                esac
            fi
            ;;
    esac
    
    # Complete options (--format, --compact, --color, etc.)
    if [[ ${cur} == -* ]]; then
        case "${prev}" in
            --format)
                COMPREPLY=( $(compgen -W "json table csv" -- ${cur}) )
                return 0
                ;;
            *)
                COMPREPLY=( $(compgen -W "${format_opts} ${common_opts}" -- ${cur}) )
                return 0
                ;;
        esac
    fi
    
    return 0
}

complete -F _pike13_completion pike13
