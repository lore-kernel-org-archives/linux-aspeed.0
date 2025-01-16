Return-Path: <linux-aspeed+bounces-498-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E300BC02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 14:18:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYlMz2rfkz30WD;
	Fri, 17 Jan 2025 01:18:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737037119;
	cv=none; b=OfnRa5yaDWR24WuvKut5NmBxGI+4MaRql4oFs8jrHMu3+ft6QJswQsGTQa18LRIJY7AwSReMk81mXNmSnWzREeRBEy4e311LSgfv4dA+QQ0ia8zeCGEORchLVLbM4I4pQ0V4nj6uGcLa32tWaw+PYkVEYEgLx2QzB3j4S49A5DCKqXnndlIM9pzLyg1FQT9pnQSEXYsDlrvqnABfUIKpUybpPtYdUPRtBjTUsmBqb1jfuBE9nKrsJ+dN4ciD2udYMsCKnMyI4tUpswKpZjiwFuXKKwlStTnL7F5N3S8dqM6Ru3WX5NPJHV+zfGTfVmI62eWakTP2c5WQv0cK5SRaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737037119; c=relaxed/relaxed;
	bh=07jjf75yKRqp1BG2/QKnRU2R3t9+MLXLq39yHvoj0rc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cLDkiYuA+88tIu76KNj3pmdFB3SrU3gw2zMSeigWkSDKPRA8iXEmaCHYm65Gr74aAwh4yxjRq55MwL08cBy26lUUOkMujZOh7D9PPrxv9h0P6FdCPem5x3rEAZecHDSnWfFaj/xeRqWUAoQrnSVsizqDnsjjtIxJOGUiXeyA4w02AqNkl8mWPTddgh8B23FSrahpN+wJ8dU2sfL4dZOfEbUX9g7/3xN8a+G1f5IcBmaf2XZ4AX53Pv6icvr7+aheLLq5oCnpX2YWbDkB10uDbjBGqtPgnnZyDjIC1K5kuCznno49wPwQYJ8C/ViAf0OXZKZewpBX1e2KdobqlhbSZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i/MWWIOD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i/MWWIOD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYlMy1Bjzz30Vy
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 01:18:37 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G3r31G004713;
	Thu, 16 Jan 2025 14:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=07jjf7
	5yKRqp1BG2/QKnRU2R3t9+MLXLq39yHvoj0rc=; b=i/MWWIODz2A0GoMRfXwNwm
	Gz/juAd9/9p+gBSS39rC3oxGVZjFI6EBosNYzyHIKoOTaI4VWqyRbPiV4BSmFz7R
	BgE1kTuvNCBP+v41le7q/nzY9B5wxQeh3vW/rJgyHrk9Sp5VXz5yqKEsWU0SkcM/
	C4QLw2XPSYsM/VTtnRX240c2872zsAcSvC2nHTvJPPyFxvHbINZhdUPHTe/L+ArP
	p/TLwmO1mkNLwG/Ry+ZAi8nj/m+UW4X28o/FwBBvyVYl+WFSfr8JUFqHq2791gq9
	ageRXGOeuWHnuXamWqswvDJdpJVseb56IenPAeH+857XcSbTYQp5qeXnav4wu5sA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhatm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 14:18:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE5GwN000874;
	Thu, 16 Jan 2025 14:18:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k5wn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 14:18:16 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GEIFUS14484142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:18:15 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301A65806A;
	Thu, 16 Jan 2025 14:18:15 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4EB85803F;
	Thu, 16 Jan 2025 14:18:13 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 14:18:13 +0000 (GMT)
Message-ID: <cba3c5e0-624b-40a2-8b52-8d07604676a1@linux.ibm.com>
Date: Thu, 16 Jan 2025 08:18:12 -0600
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: aspeed: Align GPIO hog name with bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116090009.87338-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250116090009.87338-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N0r0N1OdzpF-ONAwsi6owq0ymllf1MDm
X-Proofpoint-ORIG-GUID: N0r0N1OdzpF-ONAwsi6owq0ymllf1MDm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160106


On 1/16/25 03:00, Krzysztof Kozlowski wrote:
> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warnings like:
>
>    aspeed-bmc-lenovo-hr630.dtb: pin_gpio_b5: $nodename:0: 'pin_gpio_b5' does not match '^.+-hog(-[0-9]+)?$'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  2 +-
>   .../aspeed-bmc-arm-stardragon4800-rep2.dts    |  4 +-
>   .../aspeed/aspeed-bmc-asrock-e3c246d4i.dts    |  2 +-
>   .../dts/aspeed/aspeed-bmc-bytedance-g220a.dts |  4 +-
>   .../dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |  2 +-
>   .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |  2 +-
>   .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  2 +-
>   .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  4 +-
>   .../dts/aspeed/aspeed-bmc-lenovo-hr630.dts    | 46 ++++++-------
>   .../dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts | 68 +++++++++----------
>   .../dts/aspeed/aspeed-bmc-opp-lanyang.dts     | 14 ++--
>   .../boot/dts/aspeed/aspeed-bmc-opp-nicole.dts | 10 +--
>   .../dts/aspeed/aspeed-bmc-opp-palmetto.dts    | 40 +++++------
>   .../dts/aspeed/aspeed-bmc-opp-romulus.dts     |  6 +-
>   .../boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |  8 +--
>   15 files changed, 107 insertions(+), 107 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> index 31c5d319aa0a..263702599767 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts
> @@ -825,7 +825,7 @@ ocp-aux-pwren-hog {
>   		line-name = "ocp-aux-pwren";
>   	};
>   
> -	bmc-ready {
> +	bmc-ready-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AC, 5) GPIO_ACTIVE_HIGH>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
> index 29c68c37e7f5..9605ccade155 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts
> @@ -201,13 +201,13 @@ &gfx {
>   };
>   
>   &gpio {
> -	pin_gpio_c7 {
> +	pin-gpio-c7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "BIOS_SPI_MUX_S";
>   	};
> -	pin_gpio_d1 {
> +	pin-gpio-d1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(D, 1) GPIO_ACTIVE_HIGH>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
> index bb2e6ef609af..93190f4e696c 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-e3c246d4i.dts
> @@ -182,7 +182,7 @@ &gpio {
>   			"CK_33M_BMC", "LFRAME", "SERIRQ", "S_PLTRST";
>   
>   	/* Assert BMC_READY so BIOS doesn't sit around waiting for it */
> -	bmc-ready {
> +	bmc-ready-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(J, 0) GPIO_ACTIVE_LOW>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts
> index 3f03a198a1a8..54a5509b04f1 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-bytedance-g220a.dts
> @@ -915,14 +915,14 @@ fan@5 {
>   };
>   
>   &gpio {
> -	pin_gpio_i3 {
> +	pin-gpio-i3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "NCSI_BMC_R_SEL";
>   	};
>   
> -	pin_gpio_b6 {
> +	pin-gpio-b6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 6) GPIO_ACTIVE_HIGH>;
>   		output-low;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> index b6bfdaea08e6..cce8d0416dc8 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-delta-ahe50dc.dts
> @@ -395,7 +395,7 @@ &gpio {
>   	 * back to one causes a power output glitch, so install a hog to keep
>   	 * it at one as a failsafe to ensure nothing accidentally touches it.
>   	 */
> -	doom-guardrail {
> +	doom-guardrail-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(E, 0) GPIO_ACTIVE_LOW>;
>   		output-low;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
> index 7364adc6b80d..2f5d4075a64a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts
> @@ -155,7 +155,7 @@ &gpio0 {
>   		/*Y0-Y7*/	"","","","","","","","",
>   		/*Z0-Z7*/	"","","","","","","","";
>   
> -	usb_power {
> +	usb-power-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> index 9961508ee872..4d9e2cd11f44 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts
> @@ -312,7 +312,7 @@ &gpio0 {
>   	/*Y0-Y7*/	"","","","","","","","",
>   	/*Z0-Z7*/   "","","","","","","","";
>   
> -	usb_power {
> +	usb-power-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
> index a4aec3010456..836b90dc7014 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
> @@ -224,14 +224,14 @@ &gpio0 {
>   	/*Y0-Y7*/	"","","","","","","","",
>   	/*Z0-Z7*/	"","","","","","","","";
>   
> -	i2c3_mux_oe_n {
> +	i2c3-mux-oe-n-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(G, 6) GPIO_ACTIVE_LOW>;
>   		output-high;
>   		line-name = "I2C3_MUX_OE_N";
>   	};
>   
> -	usb_power {
> +	usb-power-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(O, 3) GPIO_ACTIVE_LOW>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts
> index ddbcbc64e235..4ad0f44af1ab 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr630.dts
> @@ -405,161 +405,161 @@ fan@13 {
>   
>   &gpio {
>   
> -	pin_gpio_b5 {
> +	pin-gpio-b5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "IRQ_BMC_PCH_SMI_LPC_N";
>   	};
>   
> -	pin_gpio_f0 {
> +	pin-gpio-f0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "IRQ_BMC_PCH_NMI_R";
>   	};
>   
> -	pin_gpio_f3 {
> +	pin-gpio-f3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "I2C_BUS0_RST_OUT_N";
>   	};
>   
> -	pin_gpio_f4 {
> +	pin-gpio-f4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "FM_SKT0_FAULT_LED";
>   	};
>   
> -	pin_gpio_f5 {
> +	pin-gpio-f5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "FM_SKT1_FAULT_LED";
>   	};
>   
> -	pin_gpio_g4 {
> +	pin-gpio-g4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(G, 4) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FAN_PWR_CTL_N";
>   	};
>   
> -	pin_gpio_g7 {
> +	pin-gpio-g7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(G, 7) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "RST_BMC_PCIE_I2CMUX_N";
>   	};
>   
> -	pin_gpio_h2 {
> +	pin-gpio-h2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "PSU1_FFS_N_R";
>   	};
>   
> -	pin_gpio_h3 {
> +	pin-gpio-h3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "PSU2_FFS_N_R";
>   	};
>   
> -	pin_gpio_i3 {
> +	pin-gpio-i3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_INTRUDED_COVER";
>   	};
>   
> -	pin_gpio_j2 {
> +	pin-gpio-j2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_BIOS_UPDATE_N";
>   	};
>   
> -	pin_gpio_j3 {
> +	pin-gpio-j3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(J, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "RST_BMC_HDD_I2CMUX_N";
>   	};
>   
> -	pin_gpio_s2 {
> +	pin-gpio-s2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_VGA_SW";
>   	};
>   
> -	pin_gpio_s4 {
> +	pin-gpio-s4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 4) GPIO_ACTIVE_HIGH>;
>   		output;
>   		line-name = "VBAT_EN_N";
>   	};
>   
> -	pin_gpio_s6 {
> +	pin-gpio-s6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "PU_BMC_GPIOS6";
>   	};
>   
> -	pin_gpio_y0 {
> +	pin-gpio-y0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Y, 0) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "BMC_NCSI_MUX_CTL_S0";
>   	};
>   
> -	pin_gpio_y1 {
> +	pin-gpio-y1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Y, 1) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "BMC_NCSI_MUX_CTL_S1";
>   	};
>   
> -	pin_gpio_z0 {
> +	pin-gpio-z0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Z, 0) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "I2C_RISER2_INT_N";
>   	};
>   
> -	pin_gpio_z2 {
> +	pin-gpio-z2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "I2C_RISER2_RESET_N";
>   	};
>   
> -	pin_gpio_z3 {
> +	pin-gpio-z3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FM_BMC_PCH_SCI_LPC_N";
>   	};
>   
> -	pin_gpio_z7 {
> +	pin-gpio-z7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Z, 7) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "BMC_POST_CMPLT_N";
>   	};
>   
> -	pin_gpio_aa0 {
> +	pin-gpio-aa0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "HOST_BMC_USB_SEL";
>   	};
>   
> -	pin_gpio_aa5 {
> +	pin-gpio-aa5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AA, 5) GPIO_ACTIVE_HIGH>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
> index 6045b60b80da..de61eac54585 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts
> @@ -425,238 +425,238 @@ fan@16 {
>   
>   &gpio {
>   
> -	pin_gpio_a1 {
> +	pin-gpio-a1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(A, 1) GPIO_ACTIVE_LOW>;
>   		output-high;
>   		line-name = "BMC_EMMC_RST_N";
>   	};
>   
> -	pin_gpio_a3 {
> +	pin-gpio-a3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(A, 3) GPIO_ACTIVE_LOW>;
>   		output-high;
>   		line-name = "PCH_PWROK_BMC_FPGA";
>   	};
>   
> -	pin_gpio_b5 {
> +	pin-gpio-b5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "IRQ_BMC_PCH_SMI_LPC_N";
>   	};
>   
> -	pin_gpio_b7 {
> +	pin-gpio-b7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
>   		output-low;
>   		line-name = "CPU_SM_WP";
>   	};
>   
> -	pin_gpio_e0 {
> +	pin-gpio-e0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(E, 0) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "PDB_PSU_SEL";
>   	};
>   
> -	pin_gpio_e2 {
> +	pin-gpio-e2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(E, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "LOCATOR_LED_N";
>   	};
>   
> -	pin_gpio_e5 {
> +	pin-gpio-e5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(E, 5) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FM_BMC_DBP_PRESENT_R1_N";
>   	};
>   
> -	pin_gpio_e6 {
> +	pin-gpio-e6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(E, 6) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_ME_SECURITY_OVERRIDE_N";
>   	};
>   
> -	pin_gpio_f0 {
> +	pin-gpio-f0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 0) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "IRQ_BMC_PCH_NMI_R";
>   	};
>   
> -	pin_gpio_f1 {
> +	pin-gpio-f1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "CPU2_PROCDIS_BMC_N";
>   	};
>   
> -	pin_gpio_f2 {
> +	pin-gpio-f2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "RM_THROTTLE_EN_N";
>   	};
>   
> -	pin_gpio_f3 {
> +	pin-gpio-f3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 3) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "FM_PMBUS_ALERT_B_EN";
>   	};
>   
> -	pin_gpio_f4 {
> +	pin-gpio-f4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_FORCE_NM_THROTTLE_N";
>   	};
>   
> -	pin_gpio_f6 {
> +	pin-gpio-f6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 6) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FM_BMC_CPU_PWR_DEBUG_N";
>   	};
>   
> -	pin_gpio_g7 {
> +	pin-gpio-g7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(G, 7) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_PCIE_I2C_MUX_RST_N";
>   	};
>   
> -	pin_gpio_h6 {
> +	pin-gpio-h6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 6) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FM_BMC_DBP_PRESENT_R2_N";
>   	};
>   
> -	pin_gpio_i3 {
> +	pin-gpio-i3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(I, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "SPI_BMC_BIOS_WP_N";
>   	};
>   
> -	pin_gpio_j1 {
> +	pin-gpio-j1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(J, 1) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_USB_SEL";
>   	};
>   
> -	pin_gpio_j2 {
> +	pin-gpio-j2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(J, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "PDB_SMB_RST_N";
>   	};
>   
> -	pin_gpio_j3 {
> +	pin-gpio-j3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(J, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "SPI_BMC_BIOS_HOLD_N";
>   	};
>   
> -	pin_gpio_l0 {
> +	pin-gpio-l0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(L, 0) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "PDB_FAN_TACH_SEL";
>   	};
>   
> -	pin_gpio_l1 {
> +	pin-gpio-l1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(L, 1) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "SYS_RESET_BMC_FPGA_N";
>   	};
>   
> -	pin_gpio_l4 {
> +	pin-gpio-l4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(L, 4) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FM_EFUSE_FAN_G1_EN";
>   	};
>   
> -	pin_gpio_l5 {
> +	pin-gpio-l5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(L, 5) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FM_EFUSE_FAN_G2_EN";
>   	};
>   
> -	pin_gpio_r6 {
> +	pin-gpio-r6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(R, 6) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "CPU3_PROCDIS_BMC_N";
>   	};
>   
> -	pin_gpio_r7 {
> +	pin-gpio-r7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "CPU4_PROCDIS_BMC_N";
>   	};
>   
> -	pin_gpio_s1 {
> +	pin-gpio-s1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 1) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "DBP_SYSPWROK_BMC";
>   	};
>   
> -	pin_gpio_s2 {
> +	pin-gpio-s2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "PCH_RST_RSMRST_N";
>   	};
>   
> -	pin_gpio_s6 {
> +	pin-gpio-s6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_HW_STRAP_5";
>   	};
>   
> -	pin_gpio_z3 {
> +	pin-gpio-z3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Z, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "FM_BMC_PCH_SCI_LPC_N";
>   	};
>   
> -	pin_gpio_aa0 {
> +	pin-gpio-aa0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "FW_PSU_ALERT_EN_N";
>   	};
>   
> -	pin_gpio_aa4 {
> +	pin-gpio-aa4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AA, 4) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "DBP_CPU_PREQ_N";
>   	};
>   
> -	pin_gpio_ab3 {
> +	pin-gpio-ab3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AB, 3) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "BMC_WDTRST";
>   	};
>   
> -	pin_gpio_ac6 {
> +	pin-gpio-ac6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AC, 6) GPIO_ACTIVE_HIGH>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
> index 370738572a55..b875b6b45083 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
> @@ -264,49 +264,49 @@ &gfx {
>   };
>   
>   &gpio {
> -	pin_gpio_b0 {
> +	pin-gpio-b0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 0) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_HDD1_PWR_EN";
>   	};
>   
> -	pin_gpio_b5 {
> +	pin-gpio-b5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 5) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "BMC_USB1_OCI2";
>   	};
>   
> -	pin_gpio_h5 {
> +	pin-gpio-h5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 5) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_CP0_PERST_ENABLE_R";
>   	};
>   
> -	pin_gpio_z2 {
> +	pin-gpio-z2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "RST_PCA9546_U177_N";
>   	};
>   
> -	pin_gpio_aa6 {
> +	pin-gpio-aa6-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AA, 6) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_CP0_RESET_N";
>   	};
>   
> -	pin_gpio_aa7 {
> +	pin-gpio-aa7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AA, 7) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_TPM_RESET_N";
>   	};
>   
> -	pin_gpio_ab0 {
> +	pin-gpio-ab0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(AB, 0) GPIO_ACTIVE_LOW>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> index b1d0ff85d397..1a7c61750d0d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> @@ -248,27 +248,27 @@ &gpio {
>   	/*AB0-AB7*/	"","","","","","","","",
>   	/*AC0-AC7*/	"","","","","","","","";
>   
> -	func_mode0 {
> +	func-mode0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   	};
> -	func_mode1 {
> +	func-mode1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   	};
> -	func_mode2 {
> +	func-mode2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(D, 5) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   	};
> -	seq_cont {
> +	seq-cont-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   	};
> -	ncsi_cfg {
> +	ncsi-cfg-hog {
>   		gpio-hog;
>   		input;
>   		gpios = <ASPEED_GPIO(E, 1) GPIO_ACTIVE_HIGH>;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
> index 45631b47a7b3..123da82c04d5 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
> @@ -209,140 +209,140 @@ &lpc_ctrl {
>   };
>   
>   &gpio {
> -	pin_func_mode0 {
> +	pin-func-mode0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(C, 4) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "func_mode0";
>   	};
>   
> -	pin_func_mode1 {
> +	pin-func-mode1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(C, 5)  GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "func_mode1";
>   	};
>   
> -	pin_func_mode2 {
> +	pin-func-mode2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(C, 6) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   		line-name = "func_mode2";
>   	};
>   
> -	pin_gpio_a0 {
> +	pin-gpio-a0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(A, 0) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "BMC_FAN_RESERVED_N";
>   	};
>   
> -	pin_gpio_a1 {
> +	pin-gpio-a1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(A, 1) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "APSS_WDT_N";
>   	};
>   
> -	pin_gpio_b1 {
> +	pin-gpio-b1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 1) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "APSS_BOOT_MODE";
>   	};
>   
> -	pin_gpio_b2 {
> +	pin-gpio-b2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "APSS_RESET_N";
>   	};
>   
> -	pin_gpio_b7 {
> +	pin-gpio-b7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(B, 7) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "SPIVID_STBY_RESET_N";
>   	};
>   
> -	pin_gpio_d1 {
> +	pin-gpio-d1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(D, 1) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_POWER_UP";
>   	};
>   
> -	pin_gpio_f1 {
> +	pin-gpio-f1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 1) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "BMC_BATTERY_TEST";
>   	};
>   
> -	pin_gpio_f4 {
> +	pin-gpio-f4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 4) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "AST_HW_FAULT_N";
>   	};
>   
> -	pin_gpio_f5 {
> +	pin-gpio-f5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 5) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "AST_SYS_FAULT_N";
>   	};
>   
> -	pin_gpio_f7 {
> +	pin-gpio-f7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(F, 7) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_FULL_SPEED_N";
>   	};
>   
> -	pin_gpio_g3 {
> +	pin-gpio-g3-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(G, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "BMC_FAN_ERROR_N";
>   	};
>   
> -	pin_gpio_g4 {
> +	pin-gpio-g4-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(G, 4) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "BMC_WDT_RST1_P";
>   	};
>   
> -	pin_gpio_g5 {
> +	pin-gpio-g5-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(G, 5) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "BMC_WDT_RST2_P";
>   	};
>   
> -	pin_gpio_h0 {
> +	pin-gpio-h0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 0) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "PE_SLOT_TEST_EN_N";
>   	};
>   
> -	pin_gpio_h1 {
> +	pin-gpio-h1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 1) GPIO_ACTIVE_HIGH>;
>   		input;
>   		line-name = "BMC_RTCRST_N";
>   	};
>   
> -	pin_gpio_h2 {
> +	pin-gpio-h2-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 2) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   		line-name = "SYS_PWROK_BMC";
>   	};
>   
> -	pin_gpio_h7 {
> +	pin-gpio-h7-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(H, 7) GPIO_ACTIVE_HIGH>;
>   		output-high;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> index 24df24ad9c80..e6b383f6e977 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> @@ -263,17 +263,17 @@ &gpio {
>   	/*AB0-AB7*/	"","","","","","","","",
>   	/*AC0-AC7*/	"","","","","","","","";
>   
> -	nic_func_mode0 {
> +	nic-func-mode0-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(D, 3) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   	};
> -	nic_func_mode1 {
> +	nic-func-mode1-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(D, 4) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   	};
> -	seq_cont {
> +	seq-cont-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
>   		output-low;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
> index 9904f0a58cfa..6ac7b0aa6e54 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
> @@ -509,25 +509,25 @@ &gpio {
>   	/*AB0-AB7*/	"","","","","","","","",
>   	/*AC0-AC7*/	"","","","","","","","";
>   
> -	line_iso_u146_en {
> +	line-iso-u146-en-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(O, 4) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   	};
>   
> -	ncsi_mux_en_n {
> +	ncsi-mux-en-n-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(P, 0) GPIO_ACTIVE_HIGH>;
>   		output-low;
>   	};
>   
> -	line_bmc_i2c2_sw_rst_n {
> +	line-bmc-i2c2-sw-rst-n-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(P, 1) GPIO_ACTIVE_HIGH>;
>   		output-high;
>   	};
>   
> -	line_bmc_i2c5_sw_rst_n {
> +	line-bmc-i2c5-sw-rst-n-hog {
>   		gpio-hog;
>   		gpios = <ASPEED_GPIO(P, 3) GPIO_ACTIVE_HIGH>;
>   		output-high;
Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

