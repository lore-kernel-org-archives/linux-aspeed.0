Return-Path: <linux-aspeed+bounces-1914-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23548C87FCB
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 13:42:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxs0k620Dz30W5;
	Wed,  6 Aug 2025 23:42:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754487734;
	cv=none; b=lcNINkawsq7NRCZ8XtRwTz+pwsQ+zDBZ01OokCMj6cNoqnnFpnT12C+n+70sczMuf2tX6Osxp09MIEwNiDdDUuKs3ZT9vCedz60BDj49wE6/A+W+7dSzJfemYT0axA3l/UoHVQw5NGMpfpNiWQOZqffKU77EZcKf72E1CAq9dxLmzzjdrphWtS2K+j2gTSCUS9UW7BTWBeATF1DfwDSkiNPNb2DGw/tM4hE8u1Z72WyN3828R5UpBDl9HOhlnbnk0X3FoOJ4TInVpnN7pDdthVXpYgQdu8UpIxqlnOLM3dCA36GjE4pp0UdKeop0ekN7SKreDN09ampOZHVFelSTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754487734; c=relaxed/relaxed;
	bh=5UsBIchovt9EWpZnlUinnSrJBmdoMS/ZpDSRkPsV+mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEiYUbcs7JVGba2Uh2GDvNfXRPHGmh+PPrt3onx7qsslABB5wiWofLg1MYVs45JF7rdewV5O6ODrOAhZGr/xrnEG3outs4UPxZX/QqEyE0BgvxxqUCQ3UrkHGolNFHHNTtyqBATOaA1KD2+wk1mj+A7BcP54M6h+F/Qt+tKf8hM2s/X1PL+YWkcVCcK4nKlyoej8g2reYqzsWdgAnjemUuyMdFjdEdKfiu34BklZGbZ0mxWNed4+NbQ6B2kRPS1AoK9zYAvoPcCYg7404x1SmcmzjT3fRNmSt7udQNPbu8BDtJ+Z+pCOV9B5sKBGAKL7ayrPVCFToPFBXsgdrotu4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jzhBVf2t; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jzhBVf2t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxs0j68Hjz2ygJ
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Aug 2025 23:42:13 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766tEDi019425;
	Wed, 6 Aug 2025 13:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5UsBIc
	hovt9EWpZnlUinnSrJBmdoMS/ZpDSRkPsV+mc=; b=jzhBVf2tz7dmcXmdxLW//p
	tQ4Z1/yiGokejR4HzByaiH/p14eIsA2q2NYwTpi+hmAvtwcP1u4nZAg8g5RrhCQa
	1CpKICj+5SWrf5gXZNio6i3FCIfbGn9nKjFTfd+pDdOk6kabsSjZVnhYnoN+aLtu
	JJwuJchu6LdopLu3GjgmxuK+hix8VeHFaREs0FxssHvsoyBTvbaeNgG4EARq8s02
	viNn779538X6SSDKPgXx4bEZEfyhHI5nW1iKKKoabckjPYwYw3yChiSOfcQgNHfQ
	zpJKcxeN1sFa9MXJzUYAuJOabmx8g7dDgMWfI2uWECmVg+/aNNXCDCQpuU1+jp1Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tss7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 13:41:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576CUqlQ022699;
	Wed, 6 Aug 2025 13:41:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqbthk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 13:41:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576DfVsB20447790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 13:41:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EDA85805E;
	Wed,  6 Aug 2025 13:41:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D323558059;
	Wed,  6 Aug 2025 13:41:30 +0000 (GMT)
Received: from [9.61.84.78] (unknown [9.61.84.78])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 13:41:30 +0000 (GMT)
Message-ID: <5c46082a-c31b-4d12-a1d6-f315c8ce7aaa@linux.ibm.com>
Date: Wed, 6 Aug 2025 08:41:30 -0500
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
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
 <20250805153908.GA1807801-robh@kernel.org>
 <OS8PR06MB75414ECA0290018D5D113B62F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <OS8PR06MB75414ECA0290018D5D113B62F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 03D1pbTw5JGzcyddECfokn0F8WPMrqqq
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=68935b8d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=V2NxCb60AAAA:8 a=VnNF1IyMAAAA:8
 a=nVsl0sAMtunpyIQNhTUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: 03D1pbTw5JGzcyddECfokn0F8WPMrqqq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA4NSBTYWx0ZWRfXz8LNxi6u9BlM
 fB+NgT8RZjvtebALNZ94xA6LJKBfnjWS/kVpYubo2dT7ak9l2QDVI0Xgtahnv7OwcRQ6S0DKoNj
 rl2NId7uCA4xBW9phCE2EVFOygPyWl0WQFzWlJbh85FaDiem46UElmOWsoP+aJiP6Fp5lfTOj2P
 vWATmvoJ/2iPsJ6cN4MnNqOv1wzhdOMNb8sN2yqrYL/4TBh8iW1n1+dcgR2WH5ArowDalu8XtX4
 Q4HI4z81AdJfIdPDQLsv8yVMmNm7t4jN6Tzrs4Dsn41F0I1UGOESNJzdRwR0ijFKQOofJVZlBOb
 H6efciLeE2l/tzedZCj6sGU+cDhAbDfuxhOhQzZuSKL1sQ+Vavvmfr/UmgXmVaeih8qxCr/+hpe
 ON2jMI9vK76TPUWHzW1IByGCkr0o+/7gY49X4O4tcPyOHBtQuIUJEH8QGqpxedD9cRlzoUNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060085


On 8/6/25 2:14 AM, Ryan Chen wrote:
>> Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
>> interrupt controllers
>>
>> On Mon, Aug 04, 2025 at 01:34:45PM +0800, Ryan Chen wrote:
>>> The AST2700 SoC follows the multi-instance interrupt controller
>>> architecture introduced in the AST2600, where each SCU interrupt group
>>> (IC0–IC3) is treated as an independent interrupt domain.
>>>
>>> Unlike the AST2600, which uses a combined register for interrupt
>>> enable and status bits, the AST2700 separates these into distinct
>>> registers: one for interrupt enable (IER) and another for interrupt
>>> status (ISR). This architectural change requires explicit handling of split
>> registers for interrupt control.
>>> - Register definitions and configuration for AST2700 SCU IC instances
>>>    (compatible: aspeed,ast2700-scu-ic0/1/2/3)
>>> - Initialization logic for handling split IER/ISR registers
>>> - Chained IRQ handling and mask/unmask logic
>>> - Table-driven registration using IRQCHIP_DECLARE per compatible
>>>
>>> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
>>> ---
>>>   drivers/irqchip/irq-aspeed-scu-ic.c | 240
>>> ++++++++++++++++++++++------
>>>   1 file changed, 195 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-aspeed-scu-ic.c
>>> b/drivers/irqchip/irq-aspeed-scu-ic.c
>>> index 1c7045467c48..b6f3ba269c5b 100644
>>> --- a/drivers/irqchip/irq-aspeed-scu-ic.c
>>> +++ b/drivers/irqchip/irq-aspeed-scu-ic.c
>>> @@ -1,6 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>>   /*
>>> - * Aspeed AST24XX, AST25XX, and AST26XX SCU Interrupt Controller
>>> + * Aspeed AST24XX, AST25XX, AST26XX, AST27XX SCU Interrupt Controller
>>>    * Copyright 2019 IBM Corporation
>>>    *
>>>    * Eddie James <eajames@linux.ibm.com> @@ -34,11 +34,42 @@
>>>   	GENMASK(5, ASPEED_AST2600_SCU_IC1_SHIFT)
>>>   #define ASPEED_AST2600_SCU_IC1_NUM_IRQS	2
>>>
>>> +#define ASPEED_AST2700_SCU_IC0_EN_REG	0x1d0
>>> +#define ASPEED_AST2700_SCU_IC0_STS_REG	0x1d4
>>> +#define ASPEED_AST2700_SCU_IC0_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC0_ENABLE	\
>>> +	GENMASK(3, ASPEED_AST2700_SCU_IC0_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC0_NUM_IRQS	4
>>> +
>>> +#define ASPEED_AST2700_SCU_IC1_EN_REG	0x1e0
>>> +#define ASPEED_AST2700_SCU_IC1_STS_REG	0x1e4
>>> +#define ASPEED_AST2700_SCU_IC1_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC1_ENABLE	\
>>> +	GENMASK(3, ASPEED_AST2700_SCU_IC1_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC1_NUM_IRQS	4
>>> +
>>> +#define ASPEED_AST2700_SCU_IC2_EN_REG	0x104
>>> +#define ASPEED_AST2700_SCU_IC2_STS_REG	0x100
>>> +#define ASPEED_AST2700_SCU_IC2_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC2_ENABLE	\
>>> +	GENMASK(3, ASPEED_AST2700_SCU_IC2_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC2_NUM_IRQS	4
>>> +
>>> +#define ASPEED_AST2700_SCU_IC3_EN_REG	0x10c
>>> +#define ASPEED_AST2700_SCU_IC3_STS_REG	0x108
>>> +#define ASPEED_AST2700_SCU_IC3_SHIFT	0
>>> +#define ASPEED_AST2700_SCU_IC3_ENABLE	\
>>> +	GENMASK(1, ASPEED_AST2700_SCU_IC3_SHIFT)
>>> +#define ASPEED_AST2700_SCU_IC3_NUM_IRQS	2
>>> +
>> The reason for ic0/ic1 compatibles before was the enable field was different.
>> Now it's at least at the same shift. Do you really need a different value for IC3?
>>
> OK, I can remove this define.
>
>> The register addresses should come from "reg". I don't understand why they
>> are hardcoded in the driver.
> The original code register is come from parent. scu_ic->scu = syscon_node_to_regmap(node->parent);
> I keep the original code logic, and add AST2700.


Hi Ryan,


How much is common with 2500/2600? I wonder if it would be easier to 
just create a new driver only for AST2700, instead of all in the same 
file/driver?


Thanks,

Eddie


>> Rob

