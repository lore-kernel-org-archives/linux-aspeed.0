Return-Path: <linux-aspeed+bounces-251-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD991E7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 17:53:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBncZ360Cz2yV8;
	Tue, 17 Dec 2024 04:53:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734371630;
	cv=none; b=knAk4l5B3pzV5GJG+FRZDvS1J/APIYGrtTiEXX9IWv7x95EAsCdVYXCCCsa2oHWpJ968ZbqumGcIhGm1Uoc3O7gbuiXdPDF5bxblt9IisVu9BCZ3WOj1PtYU39iln9xQfGMMFwY/3CYywNnobWprvGqIuZ+2Uo0yOl2wzO05WOm2RcUp72IEaPkq12VB6CTGcicpdOuIl7z2qjvbeUIxR3oipLm9kc0AsTDBw7K2fS119ddbusSPQMZiiE4rJ+U4KouEJ+UXjhp582IYT5yhtAiQc7EXaCN750nRKUpfOEfRN1smEQPdXW94EYjtGbexBq5qMZCdAAwTcpqRBBy5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734371630; c=relaxed/relaxed;
	bh=9U/ilXh/eRoLsnqCHshZWK39IQwc60QO0ixa1oM/5QI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CtgSy7438l6mqjiQi7zO5JJGltSrOvxyb4UH61xg4/eO/IHRZnDBs5bQgBLCcckSTjsV5gsPpskXqluZFO1CcxZyGzSx32k51hbV7YRd9lOiUGp1+qHENn7/4cjG2UfCB2awNgvG9uNF9cIszP3nvIBTjchOYeKidKyL2DwcMV5c+MDBQTEVmcIYo9hy60rkCfR2eUattiL+p/KTCjfGmiXp6qdHuZDHezNCualMbxNkoz3vhFrX4e4ey2O1p6v0rWmPQ4F9ulFoY5C3SPriXfKhNFwgEd5XJha3Lj/nndc3mMJ2GLy/WRBfTLaGR2XxkM6r9lr2CM/3076NFIVKXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RfWMmxEC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RfWMmxEC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBncY2hW6z2xjJ
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 04:53:49 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG85ZLx027025;
	Mon, 16 Dec 2024 17:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9U/ilX
	h/eRoLsnqCHshZWK39IQwc60QO0ixa1oM/5QI=; b=RfWMmxEC0RengRjOBhBROo
	OAORxdP+bf3+X01t/t/taikTSx7WvA8uuooEP4z9/UpofmssBY1dbhb9CAyWF28B
	zr3Mx6gfY7e1JI2F1lMjSlqrINo9FwTW3/F5LV2lR0D1iR4DRZxE3fTvDBgn+LYU
	1IFvbYw84juKAhuUj1xyNpfxs8Q/eauRlIn12MMMIkju+bNKiGDJfDMKeTwegcaH
	AXpe7VLXb3B0amsAaBtEUwJDvCiuMXdDD/jjxv1AqQVixl0PSZva+WDtjof3Mbdi
	Ay3TJvS8SgMsyF9PzN/ggm7oThp9Z0FUXBi1CSU66hHG6KYo2UEo0gZkB3UWYAfA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2astr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 17:53:30 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGHAPDH027554;
	Mon, 16 Dec 2024 17:53:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jgd2astm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 17:53:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGHCfSo014344;
	Mon, 16 Dec 2024 17:53:28 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqxy62j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 17:53:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGHrSKK16450262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 17:53:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CA2F58054;
	Mon, 16 Dec 2024 17:53:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5892C5805C;
	Mon, 16 Dec 2024 17:53:27 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 17:53:27 +0000 (GMT)
Message-ID: <b5f5635a-a807-42ea-a81f-22b80fe4eda0@linux.ibm.com>
Date: Mon, 16 Dec 2024 11:53:27 -0600
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
Subject: Re: [PATCH v1 1/4] hwmon: pmbus-core: Add label for fan and temp
To: Guenter Roeck <linux@roeck-us.net>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, eajames@linux.ibm.com, jdelvare@suse.com,
        corbet@lwn.net, joel@jms.id.au, andrew@codeconstruct.com.au,
        Delphine_CC_Chiu@Wiwynn.com, broonie@kernel.org,
        peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
        naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
        patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org
References: <20241212214927.3586509-1-ninad@linux.ibm.com>
 <20241212214927.3586509-2-ninad@linux.ibm.com>
 <f9d881b7-7301-476e-b281-0380dfcf0e10@roeck-us.net>
 <c7717f89-65cc-4668-a3e0-ee042cdcd426@linux.ibm.com>
 <2713e85d-f88a-49d6-8221-151e8631758c@roeck-us.net>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <2713e85d-f88a-49d6-8221-151e8631758c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vyxuOXaWbKmODO8fmrlBccyobF9kgdWW
X-Proofpoint-GUID: zeKm9EyZZPe56r_CuCPOaDwnvBKsFpAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 mlxlogscore=689 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160146

Hi Guenter,


On 12/13/24 11:08, Guenter Roeck wrote:
> On 12/13/24 08:12, Ninad Palsule wrote:
>> Hello Guenter,
>>
>> On 12/12/24 16:06, Guenter Roeck wrote:
>>> On 12/12/24 13:49, Ninad Palsule wrote:
>>>> Adding label files for fan and temperature sensors in the power 
>>>> supply.
>>>> The openbmc application dbus-sensor(psusensor) requires those files to
>>>> consfigure those sensors.
>>>> Note that prefix for temp label is temp[A..C] used instead of 
>>>> temp[1..3]
>>>> as dbus-sensor(psusensor) application calculate index based on last
>>>> digit in the name so we do not want to make index double digit after
>>>> appending page index.
>>>>
>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>>
>>> We are not going to fix userspace problems in the kernel.
>>>
>>> Guenter
>>>
>>
>> Thanks for the quick review.
>>
>> Sorry I am not clear on this. I feel that it is better to support 
>> labels for temperature
>>
>> sensors and fans like other. Are you saying we should not support 
>> these labels or
>>
>> I need update in the patch to support them better?
>>
>
> There should be no such labels. Labels are supposed to have specific 
> meanings,
> such as "this is the CPU temperature sensor", not vague meanings such 
> as "tempA".
>
> Guenter

Thanks for the quick response. I will remove these changes for now and 
will talk to you later about

better option.

Thanks & Regards,

Ninad Palsule


