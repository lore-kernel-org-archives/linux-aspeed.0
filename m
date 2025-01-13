Return-Path: <linux-aspeed+bounces-462-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9459DC02180
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 19:52:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX2wq0Zz4z2yXY;
	Tue, 14 Jan 2025 06:52:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736797963;
	cv=none; b=lZnKJkxtBQ55CeaR8dLTu4KnpHYT3wMi+Qt7RKm8nf4aiINpA7dCd0uYfAn5BUd0/ZGdsIEtwchOTYboC1a0cNrSp9zanRkw+6CncUxMiitc/liNQ+tZFisFWzNdkgHsrNVYctIb+vdF8NuXyRydAU1HSRElMiYwyMk20y4JXD+w5aLb+A9emavHNJNXknGHyj/sHYn97FLTOLqwVeZlPf3b+5UyKykAjXiyQPW3NxqXBZN74oQ9iX/hlzYJJjfxQ+rgVfnt0BFm76YOiMaXQM46XmEDIXXp7YUOmCKXgAxGD/hpd+YZpAR78NsQqco913WoeeqShJ63YUFQWMse3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736797963; c=relaxed/relaxed;
	bh=gxfl05rEtPi8TykQ9QWVEg0MU5uCG4bE8pKLfbkmBoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLHjwMNkkI4Gge+3A24YrcpotuLtRpT5nfw16T2QSQcKYBHmFyW7JoOBRq6bywK2GVYxtpwBhMIFM+j7Bkeuv9dqgVncqv6cWEpWqo0pFMy8k9TWeJ54COb0JT+oIcFk9I1rXKwo8QhRmKhc69cnE9+4eeSndWNLIA/ggUQpGoZeGOU6kJ0ncj3Fk4PIeGubwGOA9XtuF6JoNOC0MzFoxtuS/v1Nbm674vboemUqcfG0hEvMAR8oe9sPPfb0HZu5IxhfEw19Xpadr9lz7pIHf+ANigUu3i4+phYJIEsMSxXm451zZjbLLHzF+Y88WNhGGlQEoVZgH/LPKIfTlb821Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B5LUh+Vg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B5LUh+Vg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX2wn63HSz2yNn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 06:52:41 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DBwHMp024143;
	Mon, 13 Jan 2025 19:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gxfl05
	rEtPi8TykQ9QWVEg0MU5uCG4bE8pKLfbkmBoM=; b=B5LUh+VgN3WK/GxgMfApyL
	zDK2JB86xVFtqkh2cISfja7SdVtOsIfkGleQzynw6Piylorb/2us6xzEeoukuQot
	dAFLlcFPUq1Dy4nmJN3LwWPknBMPu5XagwtLREWveMQ8Ja5OVu7SogufvkYi8w1l
	r93va9nGzztbSiS+6nSIEy3MiVOTLcHqBQyWAU3peLOp5LcyOOT74MNka5aZKhT+
	pY3A1y/SdCxh3cPB/jbMtSDqplAF1ENBHzsX9sLyZFrgMN93Yn5jthXy+DnLG2We
	uombPBbmzmebvuAtrUsPTfV2bdOLDT7qGqBK6A2esZdY9TuHPYmiYNMuBnWtf3vQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjameav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:52:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJcxT5031944;
	Mon, 13 Jan 2025 19:52:05 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjameaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:52:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGREZB016991;
	Mon, 13 Jan 2025 19:52:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fjyrwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:52:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJq3p520972040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:52:04 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFB9A5805E;
	Mon, 13 Jan 2025 19:52:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2274F5805A;
	Mon, 13 Jan 2025 19:52:02 +0000 (GMT)
Received: from [9.61.105.40] (unknown [9.61.105.40])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:52:01 +0000 (GMT)
Message-ID: <a8893ef1-251d-447c-b42f-8f1ebc9623bb@linux.ibm.com>
Date: Mon, 13 Jan 2025 13:52:01 -0600
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
Subject: Re: [PATCH v3 00/10] DTS updates for system1 BMC
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, davem@davemloft.net, edumazet@google.com,
        andrew@codeconstruct.com.au, netdev@vger.kernel.org, kuba@kernel.org,
        joel@jms.id.au, linux-arm-kernel@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        ratbert@faraday-tech.com, eajames@linux.ibm.com,
        devicetree@vger.kernel.org, andrew+netdev@lunn.ch, minyard@acm.org,
        krzk+dt@kernel.org
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <173637565834.1164228.2385240280664730132.robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <173637565834.1164228.2385240280664730132.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PvzTUGLChZmlLTohpy8SLvK47px5mEq9
X-Proofpoint-ORIG-GUID: slslK2Na7MpzUMJx3_V1bJjHIgILrmix
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=886 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130156

Hello,

On 1/8/25 16:34, Rob Herring (Arm) wrote:
> On Wed, 08 Jan 2025 10:36:28 -0600, Ninad Palsule wrote:
>> Hello,
>>
>> Please review the patch set.
>>
>> V3:
>> ---
>>    - Fixed dt_binding_check warnings in ipmb-dev.yaml
>>    - Updated title and description in ipmb-dev.yaml file.
>>    - Updated i2c-protocol description in ipmb-dev.yaml file.
>>
>> V2:
>> ---
>>    Fixed CHECK_DTBS errors by
>>      - Using generic node names
>>      - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
>>      - Adding binding documentation for IPMB device interface
>>
>> NINAD PALSULE (7):
>>    ARM: dts: aspeed: system1: Add IPMB device
>>    ARM: dts: aspeed: system1: Add GPIO line name
>>    ARM: dts: aspeed: system1: Add RGMII support
>>    ARM: dts: aspeed: system1: Reduce sgpio speed
>>    ARM: dts: aspeed: system1: Update LED gpio name
>>    ARM: dts: aspeed: system1: Remove VRs max8952
>>    ARM: dts: aspeed: system1: Mark GPIO line high/low
>>
>> Ninad Palsule (3):
>>    dt-bindings: net: faraday,ftgmac100: Add phys mode
>>    bindings: ipmi: Add binding for IPMB device intf
>>    ARM: dts: aspeed: system1: Disable gpio pull down
>>
>>   .../devicetree/bindings/ipmi/ipmb-dev.yaml    |  44 +++++
>>   .../bindings/net/faraday,ftgmac100.yaml       |   3 +
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 177 ++++++++++++------
>>   3 files changed, 165 insertions(+), 59 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>
>> --
>> 2.43.0
>>
>>
>>
>
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>    pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-ibm-system1.dtb' for 20250108163640.1374680-1-ninad@linux.ibm.com:
>
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	from schema $id: http://devicetree.org/schemas/gpio/aspeed,ast2400-gpio.yaml#

This is a false positive. So ignoring it.

Regards,

Ninad

>
>
>
>
>
>

