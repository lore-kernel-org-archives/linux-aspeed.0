Return-Path: <linux-aspeed+bounces-124-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672B5D597A4
	for <linux-aspeed@archiver.kernel.org>; Tue, 12 Nov 2024 20:46:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xnz3p5Wcnz2xg3;
	Wed, 13 Nov 2024 07:46:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731444406;
	cv=none; b=j1FgPlyPvzBP8J9AI3y2IuVNVcA+Ss+PIf8OBdCWL/Yg4hUrXjdLBkBNXLYWOVlFPNPg/O7lYimP9TExApYua4bz9S3Oox4r14Gln8z80w9L8eDgXc8X+hNg98pMfSdhT5K098cSE7mhXP9CY6WfgKM9N+PCqrmCLXPzkfrJr/aFuUEjvZnGhtbGH7BcPFIeNkGkkG4kHQR6+m6bxpnLRCQ590BVjR2RnXTSR0V8eJslR02Ihp0tpRlUp6Tl5KWgdMf5Gwj/yTdxcfRskI+Ro/RsnI/ZBEk4ERDgproRdcZH6QER8QFKBRl9U8qqveVWDC5L54xwmlc5QS5FtPlpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731444406; c=relaxed/relaxed;
	bh=RvdgDINoXFhK8K3r+lG+Sv1e/KZonox43PzTJbkP32c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JCTIJJupN/jaktsNoRp2kWz0VrR1nCy3lOw68BUwf1FMbphexZZlhESjuSgF4AQHD6QluXqzQb7Dcgh/MEvnmU3GYqHCv1viDcu/iN92GUDRuSTvOnApXMUXXxeUtG1oNH+ZF9GvgxdP768QuB03dSYsC5ZbZDaFxxhZ4ytRb0GbQvO3tppTPAc234byHnzxOaWAS273h4tjhsaYJS+qbeYMSz/qHWxOM3LtTc4PktgzEvPtAc/4CX1B3UIka8OTTjC8S5moo7WFVcFK2/rU3xkyBZU4Ajg7RffuFt2KFMWfRvoakmDEQChPYmZXXZ2p9xza5RdnrcTM+C146sPASA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L11buY95; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L11buY95;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xnz3n36tfz2xLR
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Nov 2024 07:46:44 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJeR8S019160;
	Tue, 12 Nov 2024 20:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RvdgDI
	NoXFhK8K3r+lG+Sv1e/KZonox43PzTJbkP32c=; b=L11buY95J1U3Tt0QuPgC5J
	tfEVY9YcmRJPO2JIIV4DLXhFcCiF1CMgQzaGw12Hmg/592HDCq7SX490EeMUXC0+
	IFcJgiH3RTxmnDzoQIrgt9lVhEi/06D3IfxmyyazFn0GMXr5TWJ926TBdoEWWrrP
	np5bRquGCqqUFtAtp28+vkkDUOs574loFyJhP12GcM832E19QXofyoZdSw5Qa428
	tBEzW/7nCmTlCEbuXDPo3CWV1q30UWV4cZB2eJnPFkZxpQQcp85QQvZOKml6keM+
	zvPlDryZn7DubkEOWVkiaiWnlWGhF1x55kQiZBbC1tVl2iLPqS+LR+fvq4VmnHAQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vdcer6tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 20:46:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACJKwxV026315;
	Tue, 12 Nov 2024 20:46:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms14uas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 20:46:27 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ACKkQsL26804752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 20:46:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D4358052;
	Tue, 12 Nov 2024 20:46:26 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F09A58056;
	Tue, 12 Nov 2024 20:46:26 +0000 (GMT)
Received: from [9.61.176.224] (unknown [9.61.176.224])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Nov 2024 20:46:26 +0000 (GMT)
Message-ID: <01099631-a08a-46cc-a2fa-7ba5b44af0cb@linux.ibm.com>
Date: Tue, 12 Nov 2024 14:46:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: aspeed: Blueridge and Rainer: Add VRM presence
 GPIOs
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241108145822.1365072-1-eajames@linux.ibm.com>
 <d4196567fc62a24922794b02adad1b6c47750760.camel@codeconstruct.com.au>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <d4196567fc62a24922794b02adad1b6c47750760.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hKveIcO7WnRc1dvlNG5J8SxPsuEmwEPZ
X-Proofpoint-ORIG-GUID: hKveIcO7WnRc1dvlNG5J8SxPsuEmwEPZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
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
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxlogscore=415
 priorityscore=1501 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411120166


On 11/10/24 17:45, Andrew Jeffery wrote:
> On Fri, 2024-11-08 at 08:58 -0600, Eddie James wrote:
>> Add GPIO line names to the GPIO expander to describe DCM and
>> VRM presence detection lines.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts | 4 ++--
>>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts   | 4 ++--
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> index 5f9a46c2abb8..d504ae84db89 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dts
>> @@ -1232,8 +1232,8 @@ led-controller@60 {
>>                  #gpio-cells = <2>;
>>   
>>                  gpio-line-names =
>> -                       "", "", "", "", "", "", "", "",
>> -                       "", "", "", "", "", "", "power-config-full-
>> load", "";
>> +                       "", "", "", "", "", "", "P10_DCM0_PRES",
>> "P10_DCM1_PRES",
>> +                       "", "", "", "", "PRESENT_VRM_DCM0_N",
>> "PRESENT_VRM_DCM1_N", "power-config-full-load", "";
>>          };
> This ends up generating checkpatch warnings about long lines when I
> apply it.
>
> I did a quick, incomplete and random survey of some other devicetrees,
> and perhaps exploding out like in [1] might help.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d85b2ad35a2ab


Oh, oops, sure thing.

Thanks,

Eddie


>
>>   
>>          led-controller@61 {
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> index a4aec3010456..eefc69d0d032 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts
>> @@ -1280,8 +1280,8 @@ pca_pres3: pca9552@60 {
>>                  #gpio-cells = <2>;
>>   
>>                  gpio-line-names =
>> -                       "", "", "", "", "", "", "", "",
>> -                       "", "", "", "", "", "", "power-config-full-
>> load", "";
>> +                       "", "", "", "", "", "", "P10_DCM0_PRES",
>> "P10_DCM1_PRES",
>> +                       "", "", "", "", "PRESENT_VRM_DCM0_N",
>> "PRESENT_VRM_DCM1_N", "power-config-full-load", "";
> Similarly here.
>
> Andrew

