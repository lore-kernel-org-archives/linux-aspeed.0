Return-Path: <linux-aspeed+bounces-4063-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43091CD4F3C
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 12:05:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJxMH74DVz2xpn;
	Mon, 18 May 2026 22:05:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779105915;
	cv=none; b=Akeo3jYYW05+wO2TOYp7Io2lPdIEF4zvOTNSz9xlj1Td4ERfjt87bcj8rr9K9CLuKPqpMqk7uK6ZzTWm/F1E/emi7EL6baY435VrZg5lL+P02ec1T38/j8yzXTP0/WEEXyM7vf+4rKaC0TSF1W/+wXr3LLu848tYuAPbGoWyhoD+RaD1w6R+K+poE5m4MaedtLyJ6pnqhzYUJta7QjugzT4SXi/+zLDoUqbiYl6XQsbax4JM5tPp+Gl/rYZ537CsjQ76oM0wCifcOImqcXEy6jfuikBJm8UB4d67M5Mt83xWYG16vfnkWKgvUloyLT6bBDWB/eRB/rz79wR8fFVagw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779105915; c=relaxed/relaxed;
	bh=m2i+uQfRRuyO+cBYn5sId9z29omA5tqKq8/dTLKGEZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B0bOK+jjI7poC2Uq8nQk8tjj7ArpM/e4tdCkS0me2z5te4XRN2IMpYDj501Zg8NPDvdzKvkA9fvI4cPoN8ovnwwicMGKD1wXqgYe78hxyZxvE3HhGmd9SIURI7fAvj7tTUEHcQdu7+6iQ5uoRzKOfyKEFHciMFszLlEWAltI+I2PF0UTuj6SQqnjsjM2nZm5qUP+Ros4gzuLDZRu+8NlhdxxfIwcJMIv0TOFu6HbTA94N45O9r4Kp2qNW4OWVT8h631SZ3xZzBnyg029vkNzEZyvHPhz8BgoWrcbPAotjdXRrW2E+jywgEezNzLTWrGtSzCimg8e6Rh3vP76BWIpLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hbydWdv/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hbydWdv/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJxMH27p9z2xPb
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 22:05:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779105914;
	bh=m2i+uQfRRuyO+cBYn5sId9z29omA5tqKq8/dTLKGEZ4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hbydWdv/VyzcYntc/hUc/vWUo12PrPBEfQSBcTxqk3cgndfZ2T0NSrx8L379vwRSa
	 KDcBErROmCDAdAhM9sZfuLu9QCXAZms05OoHHK9gufTUdl5gW2SnTq34B2S7sev1yh
	 Q+Yh6OxW5oxQpWIBaZ0hwUNiOH6u38xOUH1s0p/gHwUsWO0TlGQT8ECU9fw0klaXsn
	 mLdi0UVeg6+aAcIF1ePxkHrE9ZV6lXcVkP4txnp+itJQp6bASuDstkL/UEgM+LUMV9
	 qeEH1+DGZBG/O3u8lYzSkiCl/EfjRCvGxFrQ9sl8l7OuUFseq+gq65RGQmhijfLjgB
	 FQCeUtrARBLFA==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 20EFE6024D;
	Mon, 18 May 2026 20:05:13 +0800 (AWST)
Message-ID: <cad3cf7ada9425cf0aafef1cd568ea229401c6fb.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/3] ARM: dts: aspeed: anacapa: restructure
 devicetree for development-phase
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Colin Huang <u8813345@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	colin.huang2@amd.com
Date: Mon, 18 May 2026 21:35:12 +0930
In-Reply-To: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
References: 
	<20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Hi Colin,

Firstly, apologies that it's taken some time for me to get to this.

Next, thanks for taking on-board the idea of separating the
devicetrees. I have some comments on that below, as I think we could
improve on what you've proposed.

On Thu, 2026-04-09 at 19:40 +0800, Colin Huang wrote:
> This series refactors the Anacapa BMC devicetree layout to better support
> development-phase hardware revisions (EVT1/EVT2) while keeping a platform
> entrypoint.
>=20
> Signed-off-by: Colin Huang <u8813345@gmail.com>
> ---
> Changes in v2:
> - Fix dtbs_check fail.
> =C2=A0 Validated by following command:
> =C2=A0=C2=A0=C2=A0 make dt_binding_check DT_SCHEMA_FILES=3Darm/aspeed/asp=
eed.yaml
> =C2=A0=C2=A0=C2=A0 make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspee=
d.yaml aspeed/aspeed-bmc-facebook-anacapa.dtb
> =C2=A0=C2=A0=C2=A0 make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspee=
d.yaml aspeed/aspeed-bmc-facebook-anacapa-evt1.dtb
> =C2=A0=C2=A0=C2=A0 make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Darm/aspeed/aspee=
d.yaml aspeed/aspeed-bmc-facebook-anacapa-evt2.dtb
> - Link to v1: https://lore.kernel.org/r/20260407-anacapa-devlop-phase-dev=
icetree-v1-0-97b96367cac3@gmail.com
>=20
> ---
> Colin Huang (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dt-bindings: arm: aspeed: add Anacapa EVT1=
 EVT2 board
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add EVT1 device=
tree and point wrapper to it
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ARM: dts: aspeed: anacapa: add EVT2 device=
tree and update wrapper
>=20
> =C2=A0.../devicetree/bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 2 +
> =C2=A0.../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts=C2=A0=C2=A0=C2=A0 |=
 1067 +++++++++++++++++++
> =C2=A0.../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts=C2=A0=C2=A0=C2=A0 |=
 1123 ++++++++++++++++++++

So it appears you've copy/pasted the evt1 content into evt2. Taking the
diff between them we see mainly changes to GPIO names. I've pasted the
diff below for reference.

I think it would be rather more succinct and maintainable to include
the evt1 dts then override the gpio-line-names properties in evt2 for
the relevant devices.

Similarly for the root compatible and the extra I2C EEPROM.

   --- aspeed-bmc-facebook-anacapa-evt1.dts	2026-05-18 21:23:03.480670629 +=
0930
   +++ aspeed-bmc-facebook-anacapa-evt2.dts	2026-05-18 21:23:03.532671920 +=
0930
   @@ -7,7 +7,7 @@
   =20
    / {
    	model =3D "Facebook Anacapa BMC";
   -	compatible =3D "facebook,anacapa-bmc-evt1", "aspeed,ast2600";
   +	compatible =3D "facebook,anacapa-bmc-evt2", "aspeed,ast2600";
   =20
    	aliases {
    		serial0 =3D &uart1;
   @@ -129,8 +129,8 @@
    		sck-gpios =3D <&gpio0 ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
    		mosi-gpios =3D <&gpio0 ASPEED_GPIO(Z, 4) GPIO_ACTIVE_HIGH>;
    		miso-gpios =3D <&gpio0 ASPEED_GPIO(Z, 5) GPIO_ACTIVE_HIGH>;
   -		cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
    		num-chipselects =3D <1>;
   +		cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
    		status =3D "okay";
   =20
    		tpm@0 {
   @@ -193,11 +193,15 @@
    	"","","","","","","","",
   =20
    	/*B0-B7*/
   -	"BATTERY_DETECT", "", "", "BMC_READY",
   -	"", "FM_ID_LED", "", "",
   +	"BATTERY_DETECT", "",
   +	"BMC_I2C1_FPGA_ALERT", "BMC_READY",
   +	"IOEXP_INT_3V3", "FM_ID_LED",
   +	"", "",
   =20
    	/*C0-C7*/
   -	"","","","","","","","",
   +	"","","","",
   +	"PMBUS_REQ_N", "PSU_FW_UPDATE_REQ_N",
   +	"", "",
   =20
    	/*D0-D7*/
    	"","","","","","","","",
   @@ -209,15 +213,17 @@
    	"","","","","","","","",
   =20
    	/*G0-G7*/
   -	"FM_MUX1_SEL", "", "", "",
   -	"", "", "FM_DEBUG_PORT_PRSNT_N", "FM_BMC_DBP_PRESENT_N",
   +	"FM_MUX1_SEL", "",
   +	"", "",	"", "",
   +	"FM_DEBUG_PORT_PRSNT_N", "FM_BMC_DBP_PRESENT_N",
   =20
    	/*H0-H7*/
    	"","","","","","","","",
   =20
    	/*I0-I7*/
   -	"", "", "", "",
   -	"", "FLASH_WP_STATUS", "BMC_JTAG_MUX_SEL", "",
   +	"","","","",
   +	"", "FLASH_WP_STATUS",
   +	"BMC_JTAG_MUX_SEL", "",
   =20
    	/*J0-J7*/
    	"","","","","","","","",
   @@ -229,29 +235,46 @@
    	"","","","","","","","",
   =20
    	/*M0-M7*/
   -	"", "BMC_FRU_WP", "", "",
   -	"", "", "", "",
   +	"PCIE_EP_RST_EN", "BMC_FRU_WP",
   +	"SCM_HPM_STBY_RST_N", "SCM_HPM_STBY_EN",
   +	"STBY_POWER_PG_3V3", "TH500_SHDN_OK",
   +	"", "",
   =20
    	/*N0-N7*/
   -	"LED_POSTCODE_0", "LED_POSTCODE_1", "LED_POSTCODE_2", "LED_POSTCODE_3"=
,
   -	"LED_POSTCODE_4", "LED_POSTCODE_5", "LED_POSTCODE_6", "LED_POSTCODE_7"=
,
   +	"LED_POSTCODE_0", "LED_POSTCODE_1",
   +	"LED_POSTCODE_2", "LED_POSTCODE_3",
   +	"LED_POSTCODE_4", "LED_POSTCODE_5",
   +	"LED_POSTCODE_6", "LED_POSTCODE_7",
   =20
    	/*O0-O7*/
   -	"","","","","","","","",
   +	"RUN_POWER_PG", "PWR_BRAKE",
   +	"CHASSIS_AC_LOSS", "BSM_PRSNT_N",
   +	"PSU_SMB_ALERT", "FM_TPM_PRSNT_0_N",
   +	"PSU_FW_UPDATING_N", "",
   =20
    	/*P0-P7*/
   -	"PWR_BTN_BMC_BUF_N", "", "ID_RST_BTN_BMC_N", "",
   -	"PWR_LED", "", "", "BMC_HEARTBEAT_N",
   +	"PWR_BTN_BMC_BUF_N", "IPEX_CABLE_PRSNT",
   +	"ID_RST_BTN_BMC_N", "RST_BMC_RSTBTN_OUT_N",
   +	"PWR_LED", "RUN_POWER_EN",
   +	"SHDN_FORCE", "BMC_HEARTBEAT_N",
   =20
    	/*Q0-Q7*/
   -	"","","","","","","","",
   +	"IRQ_PCH_TPM_SPI_LV3_N", "USB_OC0_REAR_N",
   +	"UART_MUX_SEL", "I2C_MUX_RESET",
   +	"RSVD_NV_PLT_DETECT", "SPI_TPM_INT",
   +	"CPU_JTAG_MUX_SELECT", "THERM_BB_OVERT",
   =20
    	/*R0-R7*/
   -	"","","","","","","","",
   +	"THERM_BB_WARN", "SPI_BMC_FPGA_INT",
   +	"CPU_BOOT_DONE", "PMBUS_GNT",
   +	"CHASSIS_PWR_BRK", "PCIE_WAKE",
   +	"PDB_THERM_OVERT", "SHDN_REQ",
   =20
    	/*S0-S7*/
   -	"", "", "SYS_BMC_PWRBTN_N", "",
   -	"", "", "", "RUN_POWER_FAULT",
   +	"", "",
   +	"SYS_BMC_PWRBTN_N", "FM_TPM_PRSNT_1_N",
   +	"FM_BMC_DEBUG_SW_N", "UID_LED_N",
   +	"SYS_FAULT_LED_N", "RUN_POWER_FAULT",
   =20
    	/*T0-T7*/
    	"","","","","","","","",
   @@ -260,7 +283,10 @@
    	"","","","","","","","",
   =20
    	/*V0-V7*/
   -	"","","","","","","","",
   +	"L2_RST_REQ_OUT", "L0L1_RST_REQ_OUT",
   +	"BMC_ID_BEEP_SEL", "BMC_I2C0_FPGA_ALERT",
   +	"SMB_BMC_TMP_ALERT", "PWR_LED_N",
   +	"SYS_RST_OUT", "IRQ_TPM_SPI_N",
   =20
    	/*W0-W7*/
    	"","","","","","","","",
   @@ -269,11 +295,12 @@
    	"","","","","","","","",
   =20
    	/*Y0-Y7*/
   -	"","","","","","","","",
   +	"RST_WDTRST_PLD_N", "RST_BMC_SELF_HW",
   +	"FM_FLASH_LATCH_N", "BMC_EMMC_RST_N",
   +	"","","","",
   =20
    	/*Z0-Z7*/
   -	"SPI_BMC_TPM_CS2_N", "", "", "SPI_BMC_TPM_CLK",
   -	"SPI_BMC_TPM_MOSI", "SPI_BMC_TPM_MISO", "", "";
   +	"","","","","","","","";
    };
   =20
    &gpio1 {
   @@ -287,7 +314,8 @@
    	"FM_BOARD_BMC_REV_ID2", "",
   =20
    	/*18C0-18C7*/
   -	"","","","","","","","",
   +	"", "", "SPI_BMC_BIOS_ROM_IRQ0_N", "",
   +	"", "", "", "",
   =20
    	/*18D0-18D7*/
    	"","","","","","","","",
   @@ -586,6 +614,11 @@
    		reg =3D <0x50>;
    	};
   =20
   +	eeprom@51 {
   +		compatible =3D "atmel,24c128";
   +		reg =3D <0x51>;
   +	};
   +
    	// BSM FRU
    	eeprom@56 {
    		compatible =3D "atmel,24c64";
   @@ -862,89 +895,106 @@
    	ngpios =3D <128>;
    	bus-frequency =3D <2000000>;
    	gpio-line-names =3D
   -	/*in - out - in - out */
   +	/*in - out */
    	/* A0-A7 line 0-15 */
   -	"", "FM_CPU0_SYS_RESET_N", "", "CPU0_KBRST_N",
   -	"", "FM_CPU0_PROCHOT_trigger_N", "", "FM_CLR_CMOS_R_P0",
   -	"", "Force_I3C_SEL", "", "SYSTEM_Force_Run_AC_Cycle",
   -	"", "", "", "",
   +	"L_FNIC_FLT", "FM_CPU0_SYS_RESET_N",
   +	"L_BNIC0_FLT", "CPU0_KBRST_N",
   +	"L_BNIC1_FLT", "FM_CPU0_PROCHOT_trigger_N",
   +	"L_BNIC2_FLT", "FM_CLR_CMOS_R_P0",
   +	"L_BNIC3_FLT", "Force_I3C_SEL",
   +	"L_RTM_SW_FLT", "SYSTEM_Force_Run_AC_Cycle",
   +	"", "",
   +	"", "",
   =20
    	/* B0-B7 line 16-31 */
    	"Channel0_leakage_EAM3", "FM_CPU_FPGA_JTAG_MUX_SEL",
    	"Channel1_leakage_EAM0", "FM_SCM_JTAG_MUX_SEL",
    	"Channel2_leakage_Manifold1", "FM_BRIDGE_JTAG_MUX_SEL",
    	"Channel3_leakage", "FM_CPU0_NMI_SYNC_FLOOD_N",
   -	"Channel4_leakage_Manifold2", "",
   -	"Channel5_leakage_EAM1", "",
   -	"Channel6_leakage_CPU_DIMM", "",
   -	"Channel7_leakage_EAM2", "",
   +	"Channel4_leakage_Manifold2", "BMC_AINIC0_WP_R2_L",
   +	"Channel5_leakage_EAM1", "BMC_AINIC1_WP_R2_L",
   +	"Channel6_leakage_CPU_DIMM", "CPLD_BUF_R_AGPIO330",
   +	"Channel7_leakage_EAM2", "CPLD_BUF_R_AGPIO331",
   =20
    	/* C0-C7 line 32-47 */
   -	"RSVD_RMC_GPIO3", "", "", "",
   -	"", "", "", "",
   -	"LEAK_DETECT_RMC_N", "", "", "",
   -	"", "", "", "",
   +	"RSVD_RMC_GPIO3", "RTM_MUX_L",
   +	"LEAK_DETECT_RMC_N", "RTM_MUX_R",
   +	"HDR_P0_NMI_BTN_BUF_R_N", "FPGA_JTAG_SCM_DBREQ_N",
   +	"No_Leak_Sensor_flag", "whdt_sel",
   +	"", "",
   +	"", "",
   +	"", "",
   +	"", "",
   =20
    	/* D0-D7 line 48-63 */
   -	"PWRGD_PDB_EAMHSC0_CPLD_PG_R", "",
   -	"PWRGD_PDB_EAMHSC1_CPLD_PG_R", "",
   -	"PWRGD_PDB_EAMHSC2_CPLD_PG_R", "",
   -	"PWRGD_PDB_EAMHSC3_CPLD_PG_R", "",
   -	"AMC_BRD_PRSNT_CPLD_L", "", "", "",
   -	"", "", "", "",
   +	"PWRGD_CHAD_CPU0_FPGA", "",
   +	"PWRGD_CHEH_CPU0_FPGA", "",
   +	"PWRGD_CHIL_CPU0_FPGA", "",
   +	"PWRGD_CHMP_CPU0_FPGA", "",
   +	"AMC_BRD_PRSNT_CPLD_L", "",
   +	"", "",
   +	"", "",
   +	"", "",
   =20
    	/* E0-E7 line 64-79 */
   -	"AMC_PDB_EAMHSC0_CPLD_EN_R", "",
   -	"AMC_PDB_EAMHSC1_CPLD_EN_R", "",
   -	"AMC_PDB_EAMHSC2_CPLD_EN_R", "",
   -	"AMC_PDB_EAMHSC3_CPLD_EN_R", "",
   -	"", "", "", "",
   -	"", "", "", "",
   +	"L_PRSNT_B_FENIC_R2_N", "",
   +	"L_PRSNT_B_BENIC0_R2_N", "",
   +	"L_PRSNT_B_BENIC1_R2_N", "",
   +	"L_PRSNT_B_BENIC2_R2_N", "",
   +	"L_PRSNT_B_BENIC3_R2_N", "",
   +	"", "",
   +	"", "",
   +	"", "",
   =20
    	/* F0-F7 line 80-95 */
   -	"PWRGD_PVDDCR_CPU1_P0", "SGPIO_READY",
   -	"PWRGD_PVDDCR_CPU0_P0", "",
   -	"", "", "", "",
   -	"", "", "", "",
   +	"R_PRSNT_B_FENIC_R2_N", "SGPIO_READY",
   +	"R_PRSNT_B_BENIC0_R2_N", "",
   +	"R_PRSNT_B_BENIC1_R2_N", "",
   +	"R_PRSNT_B_BENIC2_R2_N", "",
   +	"R_PRSNT_B_BENIC3_R2_N", "",
   +	"", "",
   +	"", "",
   +	"", "",
   =20
    	/* G0-G7 line 96-111 */
   -	"PWRGD_PVDDCR_SOC_P0", "",
   -	"PWRGD_PVDDIO_P0", "",
   -	"PWRGD_PVDDIO_MEM_S3_P0", "",
   -	"PWRGD_CHMP_CPU0_FPGA", "",
   -	"PWRGD_CHIL_CPU0_FPGA", "",
   -	"PWRGD_CHEH_CPU0_FPGA", "",
   -	"PWRGD_CHAD_CPU0_FPGA", "FM_BMC_READY_PLD",
   +	"L_PRSNT_EDSFF2_N", "",
   +	"L_PRSNT_EDSFF3_N", "",
   +	"R_PRSNT_EDSFF2_N", "",
   +	"R_PRSNT_EDSFF3_N", "",
   +	"", "",
    	"", "",
   +	"", "",
   +	"PRSNT_NFC_BOARD_R", "",
   =20
    	/* H0-H7 line 112-127 */
   -	"PWRGD_P3V3", "",
   -	"P12V_DDR_IP_PWRGD_R", "",
   -	"P12V_DDR_AH_PWRGD_R", "",
   -	"PWRGD_P12V_VRM1_CPLD_PG_R", "",
   -	"PWRGD_P12V_VRM0_CPLD_PG_R", "",
   -	"PWRGD_PDB_HSC4_CPLD_PG_R", "",
   -	"PWRGD_PVDD18_S5_P0_PG", "",
   -	"PWRGD_PVDD33_S5_P0_PG", "",
   +	"R_FNIC_FLT", "",
   +	"R_BNIC0_FLT", "",
   +	"R_BNIC1_FLT", "",
   +	"R_BNIC2_FLT", "",
   +	"R_BNIC3_FLT", "",
   +	"R_RTM_SW_FLT", "",
   +	"", "",
   +	"", "",
   =20
    	/* I0-I7 line 128-143 */
    	"EAM0_BRD_PRSNT_R_L", "",
    	"EAM1_BRD_PRSNT_R_L", "",
    	"EAM2_BRD_PRSNT_R_L", "",
    	"EAM3_BRD_PRSNT_R_L", "",
   -	"EAM0_CPU_MOD_PWR_GD_R", "",
   -	"EAM1_CPU_MOD_PWR_GD_R", "",
   -	"EAM2_CPU_MOD_PWR_GD_R", "",
   -	"EAM3_CPU_MOD_PWR_GD_R", "",
   +	"FM_TPM_PRSNT_R_N", "",
   +	"PDB_PRSNT_R_N", "",
   +	"PRSNT_EDSFF0_N", "",
   +	"PRSNT_CPU0_N", "",
   =20
    	/* J0-J7 line 144-159 */
   -	"PRSNT_L_BIRDGE_R", "",
   -	"PRSNT_R_BIRDGE_R", "",
   +	"PRSNT_L_BRIDGE_R", "",
   +	"PRSNT_R_BRIDGE_R", "",
    	"BRIDGE_L_MAIN_PG_R", "",
    	"BRIDGE_R_MAIN_PG_R", "",
    	"BRIDGE_L_STBY_PG_R", "",
    	"BRIDGE_R_STBY_PG_R", "",
   -	"", "", "", "",
   +	"IRQ_NFC_BOARD_R", "",
   +	"RSMRST_N", "",
   =20
    	/* K0-K7 line 160-175 */
    	"ADC_I2C_ALERT_N", "",
   @@ -957,10 +1007,14 @@
    	"PDB_ALERT_R_N", "",
   =20
    	/* L0-L7 line 176-191 */
   -	"CPU0_SP7R1", "", "CPU0_SP7R2", "",
   -	"CPU0_SP7R3", "", "CPU0_SP7R4", "",
   -	"CPU0_CORETYPE0", "", "CPU0_CORETYPE1", "",
   -	"CPU0_CORETYPE2", "", "FM_BIOS_POST_CMPLT_R_N", "",
   +	"CPU0_SP7R1", "",
   +	"CPU0_SP7R2", "",
   +	"CPU0_SP7R3", "",
   +	"CPU0_SP7R4", "",
   +	"CPU0_CORETYPE0", "",
   +	"CPU0_CORETYPE1", "",
   +	"CPU0_CORETYPE2", "",
   +	"FM_BIOS_POST_CMPLT_R_N", "",
   =20
    	/* M0-M7 line 192-207 */
    	"EAM0_SMERR_CPLD_R_L", "",
   @@ -978,27 +1032,29 @@
    	"AMC_STBY_PGOOD_R", "",
    	"CPU_AMC_SLP_S5_R_L", "",
    	"AMC_CPU_EAMPG_R", "",
   -	"", "", "", "",
   +	"DIMM_PMIC_PG_TIMEOUT", "",
   +	"EAM_MOD_PWR_GD_TIMEOUT", "",
   +	"CPLD_AMC_STBY_PWR_EN", "",
   =20
    	/* O0-O7 line 224-239 */
    	"HPM_PWR_FAIL", "Port80_b0",
    	"FM_DIMM_IP_FAIL", "Port80_b1",
    	"FM_DIMM_AH_FAIL", "Port80_b2",
    	"HPM_AMC_THERMTRIP_R_L", "Port80_b3",
   -	"FM_CPU0_THERMTRIP_N", "Port80_b4",
   +	"cpu_thermtrip_detect", "Port80_b4",
    	"PVDDCR_SOC_P0_OCP_L", "Port80_b5",
    	"CPLD_SGPIO_RDY", "Port80_b6",
   -	"", "Port80_b7",
   +	"FM_MAIN_PWREN_RMC_EN_ISO", "Port80_b7",
   =20
    	/* P0-P7 line 240-255 */
    	"CPU0_SLP_S5_N_R", "NFC_VEN",
    	"CPU0_SLP_S3_N_R", "",
    	"FM_CPU0_PWRGD", "",
    	"PWRGD_RMC", "",
   -	"FM_RST_CPU0_RESET_N", "",
   -	"FM_PWRGD_CPU0_PWROK", "",
   -	"wS5_PWR_Ready", "",
   -	"wS0_ON_N", "PWRGD_P1V0_AUX";
   +	"FM_RST_CPU0_RESET_N", "RBB_CPLD_RISCV_RST",
   +	"FM_PWRGD_CPU0_PWROK", "LBB_CPLD_RISCV_RST",
   +	"AMC_FAIL", "HPM_CPLD_RISCV_RST",
   +	"wS0_ON_N", "";
    	status =3D "okay";
    };
   =20
  =20

