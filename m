From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Date: Mon, 28 Mar 2022 11:09:38 +0200
Subject: [Linux-stm32] [RFC PATCH 1/1] ARM/arm64: categorize dts in arm
 dir and fix dependency in arm64
In-Reply-To: <20220328000915.15041-2-ansuelsmth@gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <20220328000915.15041-2-ansuelsmth@gmail.com>
Message-ID: <fef4e5dd-d843-ea37-7701-bcfac9d1c9b5@foss.st.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Ansuel

On 3/28/22 02:09, Ansuel Smith wrote:
> - Categorize every dts in arm directory in subdirectory
> - Fix Makefile to address for the arm subdirectory
> - Fix any arm64 dependency
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

>  create mode 100644 arch/arm/boot/dts/st/Makefile
>  rename arch/arm/boot/dts/{ => st}/spear1310-evb.dts (100%)
>  rename arch/arm/boot/dts/{ => st}/spear1310.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear1340-evb.dts (100%)
>  rename arch/arm/boot/dts/{ => st}/spear1340.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear13xx.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear300-evb.dts (100%)
>  rename arch/arm/boot/dts/{ => st}/spear300.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear310-evb.dts (100%)
>  rename arch/arm/boot/dts/{ => st}/spear310.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear320-evb.dts (100%)
>  rename arch/arm/boot/dts/{ => st}/spear320-hmi.dts (100%)
>  rename arch/arm/boot/dts/{ => st}/spear320.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear320s.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear3xx.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st}/spear600-evb.dts (100%)
>  rename arch/arm/boot/dts/{ => st}/spear600.dtsi (100%)


All SPEAr device tree should go into stm sub-directory, as this platform is a STMicroelectronics one
as STi or STM32.

Thanks

Patrice

>  create mode 100644 arch/arm/boot/dts/st_ericsson/Makefile
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ab8500.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ab8505.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-db8500.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-db8520.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-db9500.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-dbx5x0-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-dbx5x0.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-ab8500.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-family-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-stuib.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-tvk1281618-r2.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-href-tvk1281618-r3.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-href.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-href520-tvk.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefprev60-stuib.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefprev60-tvk.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefprev60.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefv60plus-stuib.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefv60plus-tvk.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-hrefv60plus.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-nhk15.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-s8815.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-nomadik-stn8815.dtsi (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-snowball.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-codina.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-gavini.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-golden.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-janice.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-kyle.dts (100%)
>  rename arch/arm/boot/dts/{ => st_ericsson}/ste-ux500-samsung-skomer.dts (100%)
>  create mode 100644 arch/arm/boot/dts/stm/Makefile
>  create mode 120000 arch/arm/boot/dts/stm/armv7-m.dtsi
>  rename arch/arm/boot/dts/{ => stm}/st-pincfg.h (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih407-b2120.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih407-clock.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih407-family.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih407-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih407.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih410-b2120.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih410-b2260.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih410-clock.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih410-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih410.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih418-b2199.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih418-b2264.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih418-clock.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stih418.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stihxxx-b2120.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32429i-eval.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32746g-eval.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f4-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f429-disco.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f429-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f429.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f469-disco.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f469-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f469.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f7-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f746-disco.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f746-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f746.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f769-disco.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32f769-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32h7-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32h743.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32h743i-disco.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32h743i-eval.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32h750.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32h750i-art-pi.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp13-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp131.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp133.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp135.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp135f-dk.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp13xc.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp13xf.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp151.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp153.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp153c-dhcom-drc02.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-avenger96.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-dhcor-avenger96.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-dk1.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1-ctouch2.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1-edimm2.2.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-icore-stm32mp1.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-iot-box.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-microgea-stm32mp1-microdev2.0.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-microgea-stm32mp1.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-stinger96.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157a-stinger96.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-dhcom-pdk2.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-dhcom-picoitx.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-dk2.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-ed1.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-emsbc-argon.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-emstamp-argon.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-ev1.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-lxa-mc1.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-odyssey-som.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp157c-odyssey.dts (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xc.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-drc02.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-pdk2.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-picoitx.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcom-som.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcor-avenger96.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcor-io1v8.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dhcor-som.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-dkx.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xx-osd32.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xxaa-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xxab-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xxac-pinctrl.dtsi (100%)
>  rename arch/arm/boot/dts/{ => stm}/stm32mp15xxad-pinctrl.dtsi (100%)
