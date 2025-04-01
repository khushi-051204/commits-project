@echo off
setlocal enabledelayedexpansion

REM Loop for April, May, June 2025
for %%m in (04 05 06) do (

    REM Days per month
    if %%m==04 (
        set max=30
    ) else if %%m==06 (
        set max=30
    ) else (
        set max=31
    )

    for /L %%d in (1,1,!max!) do (

        REM Skip logic (~few days skipped)
        set /a skip=!random! %% 15

        if !skip! == 0 (
            echo Skipping %%m-%%d
        ) else (

            REM Random commits (1–10)
            set /a commits=!random! %% 10 + 1

            echo %%m-%%d → !commits! commits

            for /L %%i in (1,1,!commits!) do (
                echo Commit %%m-%%d-%%i >> file.txt
                git add .

                REM Proper day format (leading zero)
                set day=%%d
                if %%d LSS 10 set day=0%%d

                set GIT_AUTHOR_DATE=2025-%%m-!day!T12:%%i:00
                set GIT_COMMITTER_DATE=2025-%%m-!day!T12:%%i:00

                git commit -m "Day %%m-!day! Commit %%i"
            )
        )
    )
)

endlocal