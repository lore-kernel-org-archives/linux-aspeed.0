Return-Path: <linux-aspeed+bounces-1877-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD480C87FCA
	for <linux-aspeed@archiver.kernel.org>; Fri,  1 Aug 2025 14:57:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4btpwP1LJqz2ymc;
	Sat,  2 Aug 2025 00:57:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754060277;
	cv=none; b=Yux1EiDB3TKk/L/l4Z1is5E2nY0zYKr6aqgZl89VCdCHLS0ogjiHmrDwY4sPoIId2nBwDOH0YihossJ5542k7NhC8R8n05z8+1ex7HDnTCIp4my/+Gp3QhslgLeSfstZLMcxuhEP1Dc+DJ0HMYLaNB4bBTdFsn0H2XXpXwszH+zRr+eCFmzIy1EZumJvBqb0pAC9gpbGHG5jYmNwxW5o4KIBYJgz364Ybce4Lhrj9M/foAeglOGwHU/5NkCCkfcyexdiBFQrcPw0jFX71I+iTSYeYz//BuYuv/V8w/if87kBYTlXTgODazG+jlhAQP9k89CA5A9NHQWOKZgP7IPJiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754060277; c=relaxed/relaxed;
	bh=hlQ1DOJOf+o8KRrAzvNc30DcHkxhSNLneGpl57lzHU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKkyIJ6DNY95A1b0oU58EEaCVWelXC1Mm/YtW8GJUHDWHqEuR967XfuSRkz1Lh9Nr1YNfl3b6mpbjEvz3l5SIC+MTqkifC4BBhg9pypwqwSqmFNzRcUcMJ+KyA8oO6BvOvShikG280Ad91PIKqzsuPYwhyuiDuBNFuDJHK8ymRf5BapMgg9oTKJw3obGf9GGzrF/XybaVKeNoNUv8GpVDcjr+igVQOc9UdbYzXrOPO9t+HmRpJ0cUo2BQd91GN9v136k8/WkxPGwdSvT/0Gx6Iictg4bODbCn+OUI1QPnb8hIqd+jD3ZNpXLO1Ycy2E7G3da6Ug1TAeCaIAU/CtnRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h8/JtZv4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h8/JtZv4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btpwN1ygTz2xjP;
	Sat,  2 Aug 2025 00:57:56 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718gCax027021;
	Fri, 1 Aug 2025 14:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hlQ1DO
	JOf+o8KRrAzvNc30DcHkxhSNLneGpl57lzHU8=; b=h8/JtZv42Zdciic2GifCsE
	pqV22lsqAHxgrekLEONoluXexW6Gy6cOFJUzVVipw7UmV6p1g7pOI5JDXdlskCQL
	c4USnXCCwR5Pbvlttsd/r0gsoAUodki6nB25Y6h1rdDlKOIbJYmWUvKLhHgbPoeu
	4f8+tDb/VvhN0QoSz0ZD3g3zRZdxZjiu8kOBiVaK1noS0D+vloEPetLMKGaQQNOa
	klcUtHufr5PypO+GpKll8WYmLI+wxXcFnJNe7yhcPQLn79xRBa8h3fn1TEyKg/Tu
	pPuabm8oU95l5sC9htGgQTs8XBQ6058OW4kk51sJH+TWAXW7fHq4dqTEyko0ERPQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu0evg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:57:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 571EOYGW006179;
	Fri, 1 Aug 2025 14:57:37 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 485bjmhnmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Aug 2025 14:57:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 571EvbVw25297530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Aug 2025 14:57:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1985E5805C;
	Fri,  1 Aug 2025 14:57:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF5385805A;
	Fri,  1 Aug 2025 14:57:36 +0000 (GMT)
Received: from [9.61.163.64] (unknown [9.61.163.64])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Aug 2025 14:57:36 +0000 (GMT)
Message-ID: <38a495ea-57c0-4348-aacd-fdebb25480d7@linux.ibm.com>
Date: Fri, 1 Aug 2025 09:57:34 -0500
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] ARM: dts: aspeed: Drop "fsi-master" compatibles
To: "Rob Herring (Arm)" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ninad Palsule <ninad@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-fsi@lists.ozlabs.org
References: <20250731-dt-fsi-cleanups-v1-0-e7b695a29fc3@kernel.org>
 <20250731-dt-fsi-cleanups-v1-2-e7b695a29fc3@kernel.org>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250731-dt-fsi-cleanups-v1-2-e7b695a29fc3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZNPXmW7b c=1 sm=1 tr=0 ts=688cd5e2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=3GMcbUWqJbNBMOgHYf4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6-sEyHptpwdBw7z5uZDLfEUSDwsekAMd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDExMyBTYWx0ZWRfX1B7Qv/ezbZkn
 1D1Bvnv11JBbaQw8siqQKSLMdymP4f/IkmyN4gwiRT3IHF2IoQgi6xreBLsv7Sf7aK5V8ee4vxY
 AgyAonGmC6XYPczKMXWVCQQNrbGZjACQYpYyNLYz1E177gJTV7ICh4X4Ws4BbZ9YWKRts9mlxge
 83BtWaA4oRdidSSSrNnbz1hh2lfH3wXs/J+QK6NJCTv/ARsp2SkN0Pvz+EqTD+3gsnKVB/Q2FFV
 TQXC05Xf4pb6k711jwtgaV9V94v+AWku0nvxKHQ4o0WLNEngY3nxjTeMXvIx13V3qUGLsgfanC4
 sYia9c0ZFmDmnGFCWUmEGi2rjd7Lgbu0LBBYOzK81jtjfeEWChqIqEozJrLTKBU5LK8n+/Vc49J
 LUVRfAjWP5NEA/ha++RBh9C6v6l/jpM2k3xxse3t+OTl3/z3hc24QPebAmnODZHdtAAiFOqx
X-Proofpoint-GUID: 6-sEyHptpwdBw7z5uZDLfEUSDwsekAMd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=902 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010113


On 7/31/25 17:12, Rob Herring (Arm) wrote:
> The "fsi-master" compatible has been used inconsistently on FSI masters.
> It doesn't have any real use or meaning, so it's easier to drop it
> everywhere than add it where missing. It is also not documented by any
> schemas (only .txt bindings).


Acked-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts     | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts      | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts      | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts    | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts     | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts       | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts       | 2 +-
>   arch/arm/boot/dts/aspeed/aspeed-g6.dtsi                 | 4 ++--
>   10 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
> index f42254ba6aeb..79c6919b3570 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts
> @@ -54,7 +54,7 @@ video_engine_memory: jpegbuffer {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
> +		compatible = "aspeed,ast2500-cf-fsi-master";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
> index 370738572a55..87acbfc0a1b7 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts
> @@ -63,7 +63,7 @@ sys_err {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "fsi-master-gpio", "fsi-master";
> +		compatible = "fsi-master-gpio";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
> index 31ff19ef87a0..6c8b966ffccc 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-mowgli.dts
> @@ -165,7 +165,7 @@ fan4 {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "fsi-master-gpio", "fsi-master";
> +		compatible = "fsi-master-gpio";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   		no-gpio-delays;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> index e5b8d07e7622..1b7c25e307bc 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts
> @@ -77,7 +77,7 @@ attention {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
> +		compatible = "aspeed,ast2500-cf-fsi-master";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
> index 45631b47a7b3..c7aa14034dc0 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-palmetto.dts
> @@ -55,7 +55,7 @@ identify {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "aspeed,ast2400-cf-fsi-master", "fsi-master";
> +		compatible = "aspeed,ast2400-cf-fsi-master";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> index 2180fa9b6f24..3c03204869e7 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts
> @@ -68,7 +68,7 @@ power {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "aspeed,ast2500-cf-fsi-master", "fsi-master";
> +		compatible = "aspeed,ast2500-cf-fsi-master";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
> index a0e8c97e944a..39d0fe46fd9e 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts
> @@ -200,7 +200,7 @@ rear-id {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "fsi-master-gpio", "fsi-master";
> +		compatible = "fsi-master-gpio";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   		no-gpio-delays;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
> index 8b1e82c8cdfe..89907b628b65 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts
> @@ -173,7 +173,7 @@ power-button {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "fsi-master-gpio", "fsi-master";
> +		compatible = "fsi-master-gpio";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   		no-gpio-delays;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
> index 9904f0a58cfa..9b49b0aa8b35 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts
> @@ -96,7 +96,7 @@ hdd_fault {
>   	};
>   
>   	fsi: gpio-fsi {
> -		compatible = "fsi-master-gpio", "fsi-master";
> +		compatible = "fsi-master-gpio";
>   		#address-cells = <2>;
>   		#size-cells = <0>;
>   		no-gpio-delays;
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 8ed715bd53aa..acdb6ae74b27 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -847,7 +847,7 @@ i2c: bus@1e78a000 {
>   
>   			fsim0: fsi@1e79b000 {
>   				#interrupt-cells = <1>;
> -				compatible = "aspeed,ast2600-fsi-master", "fsi-master";
> +				compatible = "aspeed,ast2600-fsi-master";
>   				reg = <0x1e79b000 0x94>;
>   				interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
> @@ -859,7 +859,7 @@ fsim0: fsi@1e79b000 {
>   
>   			fsim1: fsi@1e79b100 {
>   				#interrupt-cells = <1>;
> -				compatible = "aspeed,ast2600-fsi-master", "fsi-master";
> +				compatible = "aspeed,ast2600-fsi-master";
>   				reg = <0x1e79b100 0x94>;
>   				interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
>   				pinctrl-names = "default";
>

