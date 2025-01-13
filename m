Return-Path: <linux-aspeed+bounces-459-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F9FC02180
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 19:50:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX2tH2g1Wz3d9t;
	Tue, 14 Jan 2025 06:50:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736797831;
	cv=none; b=VFEE8wjuCOX7C31nrQDyICDLLmznfKzNnCKd88peHXay83y8Ht+Z+DcJwYwHztpkCEP2Z0DV6k/Ogd+uZds4iIoHUfAmi2zHfeiUXTNg6c8lrWhLql8vX5K4g0fDBHXBMPlStirnuMOPuvN1Gt400x+7PijBtN4oby6EEU+wYP6gHmzcjLNBk1MmsH8rqrX7BgsVPS57/58K1XxM3P7fLhRf8DArKqUjLsQ+4unxViBiYVa3qa6ylVl3cjGAHz2NGLN0qjI5bUmzE7qLdwIcFMHuTbxYggIebYGUqJI+LmmTjy0tHs3i8KTfT9JpfhGYb71R/GWQfZx2G7kIaiZcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736797831; c=relaxed/relaxed;
	bh=5kyL2H8ZkP+GQjvltdlKyAgwKTSuF4YD7lv5d98daOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYn7rT/moelJVJq8D6iMiaVfUeZCrY6auKNNvj14F9vgrt8I9nOpVmLQ3fOuUlw8Kyyi31h3+mjzIu6EW3bOX4ARHCkjaaFu/e22bHhVnYiAAEU+lk+1vDmBNr4YAE+cFeBVr8KjaI5dSQWfo9N62ZvOvskpjCP1dznnkNOP0w45oXOuBcXVk2x90fzrDKx7N+5Hh1fbkMKrTuc4fMFVkbhXmwgRB9LM4wdg3BQeX4uoLLQGhiur4AXZ/UnN2O6Q+dwQ9IyCWczqtoXBQmqRdQMS4pL8sixzVb4AquCcQ1YaXf25SUc60Hz0bmni45iOHSosqqF9Lw4dOHpapT4PAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qoMcoOYW; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qoMcoOYW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX2tG0wzCz3d9W
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 06:50:29 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE6P7K019514;
	Mon, 13 Jan 2025 19:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5kyL2H
	8ZkP+GQjvltdlKyAgwKTSuF4YD7lv5d98daOU=; b=qoMcoOYWJctffQSXm6K5fv
	2vDfBUCGzHqGCRbiHbn7nlvb1YENsvK0yaJn9mZPLj+0w9vmebLgj8b9JmfBrMVu
	nzr/I77mRFMGAkZGPPR4Q1dtEzNhO4ELfrmoAuRERuvsSUCjQ3YsDpraxXS+gC7V
	PiZxecTB71VG5tfufz/wY7mhQcWYWtUo0lB/mv3/vuBEWSEE74w2cmVxiSWYqjLu
	B8kFkhwM5QdeiSntfhsqptoDWX8xLQn4Gekdkal5jv5eawbTfMT+qmw8yI0u+mva
	m/rBCW4kcM74XtU96FdvnTm1ga69G3rzKLbZbQ0DLFKiLUPVlqzqVqpsKExRtv5w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a59hps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJllII014627;
	Mon, 13 Jan 2025 19:49:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a59hpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHmNDn016499;
	Mon, 13 Jan 2025 19:49:54 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1fghh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:54 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJnsvZ29360840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:49:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E3B958051;
	Mon, 13 Jan 2025 19:49:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C7535805A;
	Mon, 13 Jan 2025 19:49:51 +0000 (GMT)
Received: from [9.61.105.40] (unknown [9.61.105.40])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:49:51 +0000 (GMT)
Message-ID: <1c5c4271-14d5-476d-a237-214558289c67@linux.ibm.com>
Date: Mon, 13 Jan 2025 13:49:50 -0600
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
Subject: Re: [PATCH v3 02/10] bindings: ipmi: Add binding for IPMB device intf
To: Rob Herring <robh@kernel.org>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ratbert@faraday-tech.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-3-ninad@linux.ibm.com>
 <20250110160713.GA2952341-robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250110160713.GA2952341-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oHBfJ6Ngusx-kcpnlkWU_Kv38wwF4eic
X-Proofpoint-ORIG-GUID: itTn4FVypjvkPxdQuKsHfXO5Xz6rrOOh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130156

Hi Rob,

On 1/10/25 10:07, Rob Herring wrote:
> On Wed, Jan 08, 2025 at 10:36:30AM -0600, Ninad Palsule wrote:
>> Add device tree binding document for the IPMB device interface.
>> This device is already in use in both driver and .dts files.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 44 +++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>> new file mode 100644
>> index 000000000000..a8f46f1b883e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: IPMB Device
>> +
>> +description: IPMB Device interface to receive request and send response
> IPMB is not defined anywhere.
>
> Which side of the interface does this apply to? How do I know if I have
> an ipmb-dev?
>
> This document needs to stand on its own. Bindings exist in a standalone
> tree without kernel drivers or docs.

Thanks for the review. I improved the documentation. Please check.

Regards,

Ninad



