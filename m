Return-Path: <linux-aspeed+bounces-536-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495B2C02181
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 16:07:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdTVv495Kz2ykn;
	Thu, 23 Jan 2025 03:07:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737562055;
	cv=none; b=YcfW8hDt3+v/lI+r5aGJQLuUtXp1pr4AEtgjUIsTJXBhFe+fXexwF93bhA3zFivJOp+ImGHEiojSjNJ9J5oQ1h/w2At/LFj69UEO///V0pTWXep14y5M57Qzxd49Dxt51qxF42ZYOpjfNHhnDqGC+vooWK81JDenz14tLFdK5wxq2MxxvJpIh8DgphZVTrMvN6Scy39gNn0j3FFPJtnmhTFRNleBUNBdlKF98bwi2yJn2HkdK8KpM/5avtOO9v/upYxrFbSOGfAeMFhswwn6oFtmioAVy0rbGpJDr6+zS3ejYt1QgfD8XSzxHVqSH9cPyIkg1Gc3+1t04ZQGhJDCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737562055; c=relaxed/relaxed;
	bh=WYcu5q0LTw0tDsc/9X7nacRjTtioaM8Yp0plJ/Pa3nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HCqT0xd1cNQTk7MTjPT7gSL77nnSp6Iw/toPaZQtsTMlZXqiDbXUfGsW2Rl2tRTityaceCtz0ubotpGouYmoFSe76P+ZZSqkzomjSfAliwXsHJtU1OMyPGPadlGoEO0Kyc9wn9FIAHgyWVHivPTHYMcIKy1z8Tm7On1eC7+a4OUM7rdeHZKYlYp+Igw9uSYkt3Qp67ymde8I+p6EDlOCfp7Py+UL6dxg8PGX9YQ2wN/DlMPr+Io/OFWOdhWGGfwG5O9UA8YTqRnZ3eYuWeaDOUVOYHL7DF1og3qQJE0smZWvOC8UrVOqIaQ3pME2lt9Pq1TcvIRE0zsYK6Fy6135Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WwlWWVTR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WwlWWVTR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdTVt3MzBz2yDS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 03:07:34 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MCPHgu013713;
	Wed, 22 Jan 2025 16:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WYcu5q
	0LTw0tDsc/9X7nacRjTtioaM8Yp0plJ/Pa3nY=; b=WwlWWVTRWi4jVsHTfxYmNK
	4xiknLBbykkGFRW/SxM1034WzILDc0VyYq2KXFjcssuhuG1ngL6QvT5oegqnzRIg
	O/YLCspgTcptX+E5w3NRgSyxNs1nL9OWC6X14MYxdgiNuRIeJUZTMOJZtqU0Io8/
	1CS321CTDIyNSTEFKZZmjcLObFZfxqsBiM0IGbZCLYLAeYDwBycVxEAidXzjN/X9
	Yx0oqPeINcvg6oJHX0qbpuJ7aiJoZwJTeE4XRiTOKALXgQRxI537hRWnYLsQLO8Y
	dvfU2s9yUI9VLk309ghOcyfR0NfGakMuD7ClD4cKB8aPhgJXsWBaESRgAtOSvWDQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bsx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:07:17 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MG7GSl011167;
	Wed, 22 Jan 2025 16:07:16 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44apr9bswx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:07:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDlJpP024231;
	Wed, 22 Jan 2025 16:07:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y9ah7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:07:15 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG7F6J64815534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:07:15 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04BD158050;
	Wed, 22 Jan 2025 16:07:15 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57DF158045;
	Wed, 22 Jan 2025 16:07:12 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:07:12 +0000 (GMT)
Message-ID: <e8d21bad-1256-4164-8dca-58b0d46ab556@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:07:10 -0600
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
Subject: Re: [PATCH v6 07/10] ARM: dts: aspeed: system1: Update LED gpio name
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-8-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-8-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kTanEyNASlBwnHSHa15M-KkxFGz2YbhF
X-Proofpoint-ORIG-GUID: NJGChWaJwrPnO9pTmeEmh6gtygeB9ReJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_06,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1011 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=898 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501220115


On 1/16/25 14:35, Ninad Palsule wrote:
> Rename LEDs with meaningful names for easier identification.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 36 +++++++++----------
>   1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index ca55a4fb6dff..1e0b1111ea9a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -116,63 +116,63 @@ vga_memory: region@bf000000 {
>   	leds {
>   		compatible = "gpio-leds";
>   
> -		led-0 {
> +		led-bmc-ready {
>   			gpios = <&gpio0 ASPEED_GPIO(L, 7) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-1 {
> +		led-bmc-hb {
>   			gpios = <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-2 {
> +		led-rear-enc-fault0 {
>   			gpios = <&gpio0 ASPEED_GPIO(S, 6) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-3 {
> +		led-rear-enc-id0 {
>   			gpios = <&gpio0 ASPEED_GPIO(S, 7) GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-4 {
> +		led-fan0-fault {
>   			gpios = <&pca3 5 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-5 {
> +		led-fan1-fault {
>   			gpios = <&pca3 6 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-6 {
> +		led-fan2-fault {
>   			gpios = <&pca3 7 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-7 {
> +		led-fan3-fault {
>   			gpios = <&pca3 8 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-8 {
> +		led-fan4-fault {
>   			gpios = <&pca3 9 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-9 {
> +		led-fan5-fault {
>   			gpios = <&pca3 10 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-a {
> +		led-fan6-fault {
>   			gpios = <&pca3 11 GPIO_ACTIVE_LOW>;
>   		};
>   
> -		led-b {
> +		led-nvmed0-fault {
>   			gpios = <&pca4 4 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-c {
> +		led-nvmed1-fault {
>   			gpios = <&pca4 5 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-d {
> +		led-nvmed2-fault {
>   			gpios = <&pca4 6 GPIO_ACTIVE_HIGH>;
>   		};
>   
> -		led-e {
> +		led-nvmed3-fault {
>   			gpios = <&pca4 7 GPIO_ACTIVE_HIGH>;
>   		};
>   	};
> @@ -368,14 +368,14 @@ &gpio0 {
>   	/*I0-I7*/	"","","","","","","","",
>   	/*J0-J7*/	"","","","","","","","",
>   	/*K0-K7*/	"","","","","","","","",
> -	/*L0-L7*/	"","","","","","","","bmc-ready",
> +	/*L0-L7*/	"","","","","","","","led-bmc-ready",
>   	/*M0-M7*/	"","","","","","","","",
>   	/*N0-N7*/	"pch-reset","","","","","flash-write-override","","",
>   	/*O0-O7*/	"","","","","","","","",
> -	/*P0-P7*/	"","","","","","","","bmc-hb",
> +	/*P0-P7*/	"","","","","","","","led-bmc-hb",
>   	/*Q0-Q7*/	"","","","","","","pch-ready","",
>   	/*R0-R7*/	"","","","","","","","",
> -	/*S0-S7*/	"","","","","","","rear-enc-fault0","rear-enc-id0",
> +	/*S0-S7*/	"","","","","","","led-rear-enc-fault0","led-rear-enc-id0",
>   	/*T0-T7*/	"","","","","","","","",
>   	/*U0-U7*/	"","","","","","","","",
>   	/*V0-V7*/	"","rtc-battery-voltage-read-enable","","power-chassis-control","","","","",

