Return-Path: <linux-aspeed+bounces-534-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0ABC02181
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 16:05:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdTS25PhZz2yDS;
	Thu, 23 Jan 2025 03:05:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737561906;
	cv=none; b=R40Cdv6N2jNLYboLrc3gF37d1SIBdf1k1jrXuOR9TEs00dze1ppdQCZeTPPUw1Jn5caWeZDQuHoPYA2ngLgA7rHWYAewhJOP0tWEzeNNPMIzqtC5Y21KxmoxyEEvO/IWHFGlrXtJNabUGB2rp+SXTZ1gOXeBfeC7C5w3MPJrUedLePPTUBs3IOpM982m0nKYHRFRGXX6p6HZYPw/WDMI97tHCLg29QDz0qerswf3A06yNoDy6DlHPy7ZoeqjB2vZOLloeJ7E69lMc735LIQjUWNfFHTEh4A+U2qGm0TmN5lrTWcAchbd4D+8iicTnLfJVJadVsTWkfdYaLAnfWnSnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737561906; c=relaxed/relaxed;
	bh=q2ub9zL+dX4HfWghjeSU/uYyolAvvvvHUZ+3ezdkEbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gWL/BHq+/Pby0nWqJ2/ompbYIBtvL/G1rzmZypr+qUlxWvlamNPecA2sgrrE8v2wDrHrQjnbZW42xJ3wrAmPvLaT04NmHjlvE9QbtVYc/y8Fu4uvBGwA+ZL3F7G4IHOUlMv06mESUX9vDKKVXxARqTreWih66HpaOx/RLRG6uFdLfDO//9WSsB8q92Ark4iQpNfyQtvYAIYna3WvAVIgG3nQTUhD8NiRXsV1fSdWlSTPCIAu+Xn02CnAzTS0feSgWnax1uRP7DdNSh0P+Lq53g5R8fmhUco/ojw8ucArvh8Nfuyqps3rULKov7yCRDEh+8VqgzcgJ+cfRSz7JYVV5Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cYTaAN1L; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cYTaAN1L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdTS16FwFz2xWT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 03:05:05 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50M7Wu3g012829;
	Wed, 22 Jan 2025 16:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q2ub9z
	L+dX4HfWghjeSU/uYyolAvvvvHUZ+3ezdkEbY=; b=cYTaAN1L5CwFBHJvu1UfeV
	N6QfMDZEfz8EaKRjftMqZeVbPDKlBkFQtTCe/YMUxAOr+nPMECnBbZjLMUuKANsR
	tknJ2X3cZ04wNr4+4a6tHrz6GZwKedT8VNkPoJxIo9gF2qykEHJq5gQUYJ6pxHCD
	kgUlgScH9DvUpYBMe6E+5BAxc7psQB2C5X0HqTJ7VglcyRvTr7FaoZJvafZwc6Km
	2JSOMoWpyjBoxBRG5iHE38YSXzbWh6QTukQmvwnE7eh8/O0UY/HClZP6yO0F3KGq
	/fLQ2JqphfgOyzmwjnLvfLvZYrW1HQWqd9T/nlKUDw9wzwp1sAJtAH8bGJF7dSaA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2akx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:04:47 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MFTGTm008895;
	Wed, 22 Jan 2025 16:04:46 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp2aku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:04:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MD6dHd019252;
	Wed, 22 Jan 2025 16:04:46 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmshbhk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:04:46 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG4jNX27329040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:04:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B69B58045;
	Wed, 22 Jan 2025 16:04:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6708058050;
	Wed, 22 Jan 2025 16:04:44 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:04:44 +0000 (GMT)
Message-ID: <3628ffd5-e1bd-4092-9b19-ebb0bfdd5b33@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:04:42 -0600
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
Subject: Re: [PATCH v6 05/10] ARM: dts: aspeed: system1: Add GPIO line name
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-6-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-6-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hIuAdrje0LogGtfM8pFI2jTDgtcyHuq_
X-Proofpoint-GUID: t5XKzSrdBav_JmniWaN9kN9wQ3Vjm0NJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=849 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> Add following GPIO line name so that userspace can control them
>      - Flash write override
>      - pch-reset


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 0d16987cfc80..973169679c8d 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -370,7 +370,7 @@ &gpio0 {
>   	/*K0-K7*/	"","","","","","","","",
>   	/*L0-L7*/	"","","","","","","","bmc-ready",
>   	/*M0-M7*/	"","","","","","","","",
> -	/*N0-N7*/	"fpga-debug-enable","","","","","","","",
> +	/*N0-N7*/	"pch-reset","","","","","flash-write-override","","",
>   	/*O0-O7*/	"","","","","","","","",
>   	/*P0-P7*/	"","","","","","","","bmc-hb",
>   	/*Q0-Q7*/	"","","","","","","pch-ready","",

