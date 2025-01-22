Return-Path: <linux-aspeed+bounces-535-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C64C02182
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 16:06:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdTT764zhz2ykn;
	Thu, 23 Jan 2025 03:06:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737561963;
	cv=none; b=M7HHHX1J3P6fpYqW0PY79dMMZ800lyGMUEZXNT7FBLu3dgCgfbyaswU588lYc3d8wK0Fms2YP4zHizzYCL+pSDtHLljl/UKAEaUMNFDP7OEb/+2j7kM7/Z/ZyFs15kyRNpzeWLQsgBWS8e1uYpSjz+xjqaHj/JwXBGuncfVm9RbAX+w8W/LzqbRDwuEgdcCTWBvpcYFvwEyI/fw8uisrPmA6AW9kn9jl0jBOwts9yNVZDlRd9CCQqX47Y+qUvgrPxw7voskhC5gkRLuJRN1mWDXxyqFbGg3YNqCmO4K5IH66dKFx4ifflvjWKKtCJHRL1H+62WKRXs0a4hKUKXwT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737561963; c=relaxed/relaxed;
	bh=Yqgb4Hb9dr4ruSA5GdqAAEQ+DZqHMDCn+QIelLJfXgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XwHrVVAYz84CKrVMc0LNj0Re5GvNpKHDqO2UuTZuwMTRHtIcCKrTOc2CSrfq24psK4vVup0NcNz1TshmCopNzDIe7ieFmU+MN1tOleY38xmQNaHK5Vj5cDm9+X0kIUUDyWmNH5X7NtKDgIssKdlmYBrTQNf1jRGg8cyV/SfRoCG4/uA3PtjN4fbMZfqJOoPiAxNBtnssBkUd+MhNliCWm7/nxQ4T5s63hA9X5dTF28N0SqEq3CN43WjQYfWP8sI8kPSp+zCsxmJhvIE3GCk0xRcPovoI2qR2LIbCe4wYdYkJutvgpByouXj7FOg227eyOzZq0GeVHz5X5sIzzN7lEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rNtbHjXj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rNtbHjXj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdTT66gWNz2yDS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 03:06:02 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MF1lUi027803;
	Wed, 22 Jan 2025 16:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Yqgb4H
	b9dr4ruSA5GdqAAEQ+DZqHMDCn+QIelLJfXgQ=; b=rNtbHjXj+UIPEaJXkF73TL
	3xBMS7BlChM5lZbSBjfkwPbjTNvGFbJifn83Z06kSeh5HEjLEvN4IMTh+tL31lZF
	bQHjOdzGbVg7FBlBd1ZrbIiNKgxUKDgGZOAxCXPr0i1SuHkX64VAFWQw55HX+5LZ
	m+SyqX4vCDjhwWwDBCt5PFCWahhrObfudrehvNn26EEoEjaaIKzfyNhWRyZYr622
	DHeeM4BYtk6TZBwkoWmxwg3fratDewtoVCdM1pP8/hqPccThgZbhfXPzcH36TlM8
	QimLPRzzv5IiVq1wa8uPeR02Xqo617OkUtaBKUDDRAx+dHyaRnQ8yB9dmVMLPaqQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b2xygbnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:05:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MG3h8J005920;
	Wed, 22 Jan 2025 16:05:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44b2xygbnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:05:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50METKrt022449;
	Wed, 22 Jan 2025 16:05:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448r4k9204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:05:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG5hLR13894358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:05:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66CB658054;
	Wed, 22 Jan 2025 16:05:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68E8E58052;
	Wed, 22 Jan 2025 16:05:42 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:05:42 +0000 (GMT)
Message-ID: <60445b72-8582-40ac-a662-330667efe88b@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:05:40 -0600
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
Subject: Re: [PATCH v6 06/10] ARM: dts: aspeed: system1: Reduce sgpio speed
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-7-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-7-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4gkP31nbzvFzigDO8wMfyvtYGuHlaZiX
X-Proofpoint-ORIG-GUID: hoZfqMlnWqqRJdnmdG1CMmpu0d1AzD-m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 mlxlogscore=613 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> Reduce sgpio speed to improve stability with the current PCB layout.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 973169679c8d..ca55a4fb6dff 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -401,7 +401,7 @@ &emmc {
>   &sgpiom0 {
>   	status = "okay";
>   	ngpios = <128>;
> -	bus-frequency = <1000000>;
> +	bus-frequency = <500000>;
>   };
>   
>   &ibt {

