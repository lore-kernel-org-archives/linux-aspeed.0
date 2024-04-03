From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 03 Apr 2024 13:51:06 +1030
Subject: [PATCH 1/3] ARM: dts: Modify GPIO table for Asrock X570D4U BMC
In-Reply-To: <20240329130152.878944-2-renze@rnplus.nl>
References: <20240329130152.878944-1-renze@rnplus.nl>
	 <20240329130152.878944-2-renze@rnplus.nl>
Message-ID: <5f1c7ac66f0ae68bbab0011c1ab5b020ecdb16b6.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Renze,

Do you mind running this patch and the others in the series through
./scripts/checkpatch.pl? Generally patches sent to the list should not
generate warnings.

It looks like these patches are generated against Joel's bmc/for-next
branch. He's applied your original X570D4U devicetree patch there,
(though that also causes checkpatch warnings).

On Fri, 2024-03-29 at 14:01 +0100, Renze Nicolai wrote:
> This commit removes button-nmi-n, this board does not have support for an NMI button.
> Input status-locatorled-n has been renamed to input-locatorled-n to better indicate the signal type.
> The suffix -n has been appended to the name of control-locatorbutton, button-power, control-power, button-reset, control-reset, input-id0, input-id1, input-id2, output-bmc-ready to reflect the inverted signal polarity.
> GPIO output-rtc-battery-voltage-read-enable has been renamed to output-hwm-vbat-enable, input-alert1-n to input-aux-smb-alert-n, input-alert3-n to input-psu-smb-alert-n, input-mfg to input-mfg-mode-n and input-caseopen to input-case-open-n.
> And GPIOs input-bmc-smb-present-n, input-pcie-wake-n, input-sleep-s3-n, input-sleep-s5-n and input-power-good have been added.
> 

For instance, checkpatch warns about these lines in the commit message
being too long. They should be wrapped at 72 characters.

Additionally, the description forms a bit of a list of things the patch
is doing. Patches are easier to review when they only do one thing, as
it removes the need to assess whether there are subtle interactions
between the several things, and if so, whether they're expected and
correct.

I'd prefer this change be split up so there's no need for such
concerns.

> Signed-off-by: Renze Nicolai <renze@rnplus.nl>
> ---
>  .../dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  | 116 +++++++++---------
>  1 file changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> index 3c975bc41ae7..34bc382bf492 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts
> @@ -79,64 +79,64 @@ iio-hwmon {
>  &gpio {
>  	status = "okay";
>  	gpio-line-names =
> -	/*A0-A3*/       "status-locatorled-n",                    "",                      "button-nmi-n",          "",
> -	/*A4-A7*/       "",                                       "",                      "",                      "",
> -	/*B0-B3*/       "input-bios-post-cmplt-n",                "",                      "",                      "",
> -	/*B4-B7*/       "",                                       "",                      "",                      "",
> -	/*C0-C3*/       "",                                       "",                      "",                      "",
> -	/*C4-C7*/       "",                                       "",                      "control-locatorbutton", "",
> -	/*D0-D3*/       "button-power",                           "control-power",         "button-reset",          "control-reset",
> -	/*D4-D7*/       "",                                       "",                      "",                      "",
> -	/*E0-E3*/       "",                                       "",                      "",                      "",
> -	/*E4-E7*/       "",                                       "",                      "",                      "",
> -	/*F0-F3*/       "",                                       "",                      "",                      "",
> -	/*F4-F7*/       "",                                       "",                      "",                      "",
> -	/*G0-G3*/       "output-rtc-battery-voltage-read-enable", "input-id0",             "input-id1",             "input-id2",
> -	/*G4-G7*/       "input-alert1-n",                         "input-alert2-n",        "input-alert3-n",        "",
> -	/*H0-H3*/       "",                                       "",                      "",                      "",
> -	/*H4-H7*/       "input-mfg",                              "",                      "led-heartbeat-n",       "input-caseopen",
> -	/*I0-I3*/       "",                                       "",                      "",                      "",
> -	/*I4-I7*/       "",                                       "",                      "",                      "",
> -	/*J0-J3*/       "output-bmc-ready",                       "",                      "",                      "",
> -	/*J4-J7*/       "",                                       "",                      "",                      "",
> -	/*K0-K3*/       "",                                       "",                      "",                      "",
> -	/*K4-K7*/       "",                                       "",                      "",                      "",
> -	/*L0-L3*/       "",                                       "",                      "",                      "",
> -	/*L4-L7*/       "",                                       "",                      "",                      "",
> -	/*M0-M3*/       "",                                       "",                      "",                      "",
> -	/*M4-M7*/       "",                                       "",                      "",                      "",
> -	/*N0-N3*/       "",                                       "",                      "",                      "",
> -	/*N4-N7*/       "",                                       "",                      "",                      "",
> -	/*O0-O3*/       "",                                       "",                      "",                      "",
> -	/*O4-O7*/       "",                                       "",                      "",                      "",
> -	/*P0-P3*/       "",                                       "",                      "",                      "",
> -	/*P4-P7*/       "",                                       "",                      "",                      "",
> -	/*Q0-Q3*/       "",                                       "",                      "",                      "",
> -	/*Q4-Q7*/       "",                                       "",                      "",                      "",
> -	/*R0-R3*/       "",                                       "",                      "",                      "",
> -	/*R4-R7*/       "",                                       "",                      "",                      "",
> -	/*S0-S3*/       "input-bmc-pchhot-n",                     "",                      "",                      "",
> -	/*S4-S7*/       "",                                       "",                      "",                      "",
> -	/*T0-T3*/       "",                                       "",                      "",                      "",
> -	/*T4-T7*/       "",                                       "",                      "",                      "",
> -	/*U0-U3*/       "",                                       "",                      "",                      "",
> -	/*U4-U7*/       "",                                       "",                      "",                      "",
> -	/*V0-V3*/       "",                                       "",                      "",                      "",
> -	/*V4-V7*/       "",                                       "",                      "",                      "",
> -	/*W0-W3*/       "",                                       "",                      "",                      "",
> -	/*W4-W7*/       "",                                       "",                      "",                      "",
> -	/*X0-X3*/       "",                                       "",                      "",                      "",
> -	/*X4-X7*/       "",                                       "",                      "",                      "",
> -	/*Y0-Y3*/       "",                                       "",                      "",                      "",
> -	/*Y4-Y7*/       "",                                       "",                      "",                      "",
> -	/*Z0-Z3*/       "",                                       "",                      "led-fault-n",           "output-bmc-throttle-n",
> -	/*Z4-Z7*/       "",                                       "",                      "",                      "",
> -	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",                      "input-cpu1-prochot-n",  "",
> -	/*AA4-AC7*/     "",                                       "",                      "",                      "",
> -	/*AB0-AB3*/     "",                                       "",                      "",                      "",
> -	/*AB4-AC7*/     "",                                       "",                      "",                      "",
> -	/*AC0-AC3*/     "",                                       "",                      "",                      "",
> -	/*AC4-AC7*/     "",                                       "",                      "",                      "";
> +	/*A0-A3*/       "input-locatorled-n",                     "",                      "",                        "",
> +	/*A4-A7*/       "",                                       "",                      "",                        "",
> +	/*B0-B3*/       "input-bios-post-cmplt-n",                "",                      "",                        "",
> +	/*B4-B7*/       "",                                       "",                      "",                        "",
> +	/*C0-C3*/       "",                                       "",                      "",                        "",
> +	/*C4-C7*/       "",                                       "",                      "control-locatorbutton-n", "",
> +	/*D0-D3*/       "button-power-n",                         "control-power-n",       "button-reset-n",          "control-reset-n",
> +	/*D4-D7*/       "",                                       "",                      "",                        "",
> +	/*E0-E3*/       "",                                       "",                      "",                        "",
> +	/*E4-E7*/       "",                                       "",                      "",                        "",
> +	/*F0-F3*/       "",                                       "",                      "",                        "",
> +	/*F4-F7*/       "",                                       "",                      "",                        "",
> +	/*G0-G3*/       "output-hwm-vbat-enable",                 "input-id0-n",           "input-id1-n",             "input-id2-n",
> +	/*G4-G7*/       "input-aux-smb-alert-n",                  "",                      "input-psu-smb-alert-n",   "",
> +	/*H0-H3*/       "",                                       "",                      "",                        "",
> +	/*H4-H7*/       "input-mfg-mode-n",                       "",                      "led-heartbeat-n",         "input-case-open-n",
> +	/*I0-I3*/       "",                                       "",                      "",                        "",
> +	/*I4-I7*/       "",                                       "",                      "",                        "",
> +	/*J0-J3*/       "output-bmc-ready-n",                     "",                      "",                        "",
> +	/*J4-J7*/       "",                                       "",                      "",                        "",
> +	/*K0-K3*/       "",                                       "",                      "",                        "",
> +	/*K4-K7*/       "",                                       "",                      "",                        "",
> +	/*L0-L3*/       "",                                       "",                      "",                        "",
> +	/*L4-L7*/       "",                                       "",                      "",                        "",
> +	/*M0-M3*/       "",                                       "",                      "",                        "",
> +	/*M4-M7*/       "",                                       "",                      "",                        "",
> +	/*N0-N3*/       "",                                       "",                      "",                        "",
> +	/*N4-N7*/       "",                                       "",                      "",                        "",
> +	/*O0-O3*/       "",                                       "",                      "",                        "",
> +	/*O4-O7*/       "",                                       "",                      "",                        "",
> +	/*P0-P3*/       "",                                       "",                      "",                        "",
> +	/*P4-P7*/       "",                                       "",                      "",                        "",
> +	/*Q0-Q3*/       "",                                       "",                      "",                        "",
> +	/*Q4-Q7*/       "input-bmc-smb-present-n",                "",                      "",                        "input-pcie-wake-n",
> +	/*R0-R3*/       "",                                       "",                      "",                        "",
> +	/*R4-R7*/       "",                                       "",                      "",                        "",
> +	/*S0-S3*/       "input-bmc-pchhot-n",                     "",                      "",                        "",
> +	/*S4-S7*/       "",                                       "",                      "",                        "",
> +	/*T0-T3*/       "",                                       "",                      "",                        "",
> +	/*T4-T7*/       "",                                       "",                      "",                        "",
> +	/*U0-U3*/       "",                                       "",                      "",                        "",
> +	/*U4-U7*/       "",                                       "",                      "",                        "",
> +	/*V0-V3*/       "",                                       "",                      "",                        "",
> +	/*V4-V7*/       "",                                       "",                      "",                        "",
> +	/*W0-W3*/       "",                                       "",                      "",                        "",
> +	/*W4-W7*/       "",                                       "",                      "",                        "",
> +	/*X0-X3*/       "",                                       "",                      "",                        "",
> +	/*X4-X7*/       "",                                       "",                      "",                        "",
> +	/*Y0-Y3*/       "input-sleep-s3-n",                       "input-sleep-s5-n",      "",                        "",
> +	/*Y4-Y7*/       "",                                       "",                      "",                        "",
> +	/*Z0-Z3*/       "",                                       "",                      "led-fault-n",             "output-bmc-throttle-n",
> +	/*Z4-Z7*/       "",                                       "",                      "",                        "",
> +	/*AA0-AA3*/     "input-cpu1-thermtrip-latch-n",           "",                      "input-cpu1-prochot-n",    "",
> +	/*AA4-AC7*/     "",                                       "",                      "",                        "",
> +	/*AB0-AB3*/     "",                                       "input-power-good",      "",                        "",
> +	/*AB4-AC7*/     "",                                       "",                      "",                        "",
> +	/*AC0-AC3*/     "",                                       "",                      "",                        "",
> +	/*AC4-AC7*/     "",                                       "",                      "",                        "";
>  };
>  

I'd like some discussion in the commit message of whether these names
align with net names in the schematic, follow the OpenBMC GPIO naming
guidelines, or use some other strategy entirely.

Also, the columnisation of the names leads to more warnings from
checkpatch (due to line length). Other Aspeed-based devicetrees tend
not to make the whitespace so significant, and generally group the
GPIOs by complete banks. I prefer that the X570D4U devicetree is
consistent with the others.

Andrew
