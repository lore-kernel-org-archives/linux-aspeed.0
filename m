Return-Path: <linux-aspeed+bounces-539-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 830F2C02181
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 16:11:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdTbN18pnz2ykn;
	Thu, 23 Jan 2025 03:11:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737562288;
	cv=none; b=k+M8XKX3hgKYGY7Q8nzrK1zh6D9PWIElP9uswZXY+pHOLPbeAvPmnispFQx4wO6qVi5p94bb0lz9hp3WPzbe3vQxrdU0EeHZNdJpUIirKrUyJH9umgxGbCVLotTWC8WukO/PjullBH3yB0CJTxPkmHKW2oKPsMnhrVfY8tuEb22dsecNvNtFOuOJ8vYJDGz36rRf0rVQi+RVZ7QdFW+RjLQBuU+Y1dd3UHOsak52bMWLAe88wZxkKM3QHZeHAujpx87i2m06L18CRsMRzmwr77lEYGYF45egmLtrOR1od/xyaMflaUiQGvJK21dZXG7hygbYWfqOsdYwxJaaVMPRUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737562288; c=relaxed/relaxed;
	bh=PztkFg57upQfl9uFVIH43wRTzPCQzZPmgJS1hWIsUPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M8Mos9D1OJVWp01yn+XFB/aVmFtragp2unHWQonu3c5xnvenahzP6tGbKsJ6JyLVGquSCdxb9KavpN5Y8AGhaGQ++VYJHDxnwn4Buq7odTnHHGayfCkSkPhTP+S+wacFOBcFG+PXRIF+6MGzpvzxXNVaOiptq1db6meK0UXh7ZHqVtJ56HFx4dAeeC1ft0IUgPAKJzYfX1+GnEIoDBFbjQtqf6D0PBvMprSHZVRWwzmgdL0gF/Isr5DlruYL1LsQLTZnYKSB6wkIYdlUX8zdTKQe6FPldqwd/Tr+bgAA3XauZROa2lI1oXVcPjVxGzZUfSY9wOY3tCiQVgnBZbBr4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y5UbnKq0; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y5UbnKq0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdTbM2723z2yDS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 03:11:27 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M7XQCM013738;
	Wed, 22 Jan 2025 16:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PztkFg
	57upQfl9uFVIH43wRTzPCQzZPmgJS1hWIsUPw=; b=Y5UbnKq09lf5xMnyzODXzE
	F1VGboZ3m+Y7XTJqgIt5Lef6SVz+4J4hYOZ1HJHoObXAUT8CVL4idNdr4L5HCE7P
	9yDTlPs+4v/UEFcU1T3v1XXzv1+MVcxN4KJ0rx/IKxl3IqM/GGbYvZYP9yb4coU+
	ZYdnyKel7B2V42WHsyOFMOglrXpAABUjxK+NWR0XLxcZ2Qf6Mbr+FMuTbNJ1PuEz
	88FTiZJCKdYrOr6ZePMe2CfJXJU2xwRLsUWF1FZXzbZgCV8PMhhztlsXfTYjSZFe
	BXm7nZIJ5dwXDlQ78EjI469vVF2Raq8CGuNWYk7AHvkSpUQ+fSH/ZJDaH9XD0G/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2bjv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:11:07 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MFqPue027924;
	Wed, 22 Jan 2025 16:11:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2bjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:11:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MD2vpu024241;
	Wed, 22 Jan 2025 16:11:05 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y9awu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:11:05 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MGB5IV9634130
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:11:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C1158045;
	Wed, 22 Jan 2025 16:11:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 804CE58050;
	Wed, 22 Jan 2025 16:11:04 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:11:04 +0000 (GMT)
Message-ID: <804bffdf-a029-4bed-a6f1-42cf4c129f2a@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:11:02 -0600
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
Subject: Re: [PATCH v6 08/10] ARM: dts: aspeed: system1: Remove VRs max8952
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-9-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-9-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZcgzZU75w_qF0eNW3_16-1LnugWQ9ohb
X-Proofpoint-GUID: Rx_zD-AK266kWu98eA7hPXtTKYAqCPtP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> Removing voltage regulators max8952 from device tree. Those are fully
> controlled by hardware and firmware should not touch them.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 34 -------------------
>   1 file changed, 34 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 1e0b1111ea9a..089a8315753a 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -486,23 +486,6 @@ eeprom@50 {
>   		compatible = "atmel,24c64";
>   		reg = <0x50>;
>   	};
> -
> -	regulator@60 {
> -		compatible = "maxim,max8952";
> -		reg = <0x60>;
> -
> -		max8952,default-mode = <0>;
> -		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
> -						<1050000>, <950000>;
> -		max8952,sync-freq = <0>;
> -		max8952,ramp-speed = <0>;
> -
> -		regulator-name = "VR_v77_1v4";
> -		regulator-min-microvolt = <770000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
>   };
>   
>   &i2c1 {
> @@ -1198,23 +1181,6 @@ eeprom@50 {
>   		compatible = "atmel,24c64";
>   		reg = <0x50>;
>   	};
> -
> -	regulator@60 {
> -		compatible = "maxim,max8952";
> -		reg = <0x60>;
> -
> -		max8952,default-mode = <0>;
> -		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
> -						<1050000>, <950000>;
> -		max8952,sync-freq = <0>;
> -		max8952,ramp-speed = <0>;
> -
> -		regulator-name = "VR_v77_1v4";
> -		regulator-min-microvolt = <770000>;
> -		regulator-max-microvolt = <1400000>;
> -		regulator-always-on;
> -		regulator-boot-on;
> -	};
>   };
>   
>   &i2c11 {

