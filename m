Return-Path: <linux-aspeed+bounces-237-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4385CE7717F
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Dec 2024 16:13:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8vWs65jLz2yVj;
	Sat, 14 Dec 2024 03:13:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734106393;
	cv=none; b=NPJwq6GgtQ86WgEzuk/lFBFcfughD8gnzI+C47xTgI7bBj6Ye5Ms8MzE7ScNzOOjLZ45WJqTHtBuMdgEbSt+9OGwr4kmNZtJ0t257Nb2tiIVp37qJsmxWz6zx8D2WEub/QIay8ldjB0pxrHVoe4xg75JRGXbccPDArJcjyFkynjYJrToqhZZG/EjmdMR/NyDitmeGez7BjgHoM4Qu9jvaP3x/5DQLGjV0efbSWpGBh0FJlYhQoLyeTNw9rkqsMCcEvh+jXN41wlzsxKEoSRIdtTHaseQUwMKjuwDKZWD0kLyknNtM6VhHs+Zop91Ns7e9PO977tM/IqS4+oErm626Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734106393; c=relaxed/relaxed;
	bh=PW1LH2F8Qxvgif3YU5Y3z1CGnrmFPIED3xPs36aiFdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WjlBxE+ZyXKpkaVk+IJuV0D1nY2NtvM3tAmMCecx8nUw5beiXfwS6k7FRku6cmjZc2iBIZJqfGkxV4wPProvT67UKpf4JdA5TK380yr0GrDpqAMIPESCnC7TuUTSb4sMXZhmjt0m4Er78u1hP9hjvYtiKSBHorhKJbO+3j5Yw0DINEX6sgF5GALE+Gs9EHVoGpSQ8myg1AOW5ZfMHZ/G7DX8sWsHAiZ1qP11CpL5Dqril22Xe+xLnw293yKBrOSlYxtWaAMe66Z3SqhgCuMaNnnI6TVTNV9f4A6/xkVDoxPC/rnh5zGfESN+TNInam3o6XGCoGUKDVW0JCnQfqpfTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IFz2XB9K; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IFz2XB9K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8vWr2zwRz2yJL
	for <linux-aspeed@lists.ozlabs.org>; Sat, 14 Dec 2024 03:13:11 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEIuv6015637;
	Fri, 13 Dec 2024 16:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PW1LH2
	F8Qxvgif3YU5Y3z1CGnrmFPIED3xPs36aiFdc=; b=IFz2XB9KxBQc8Ujd8Xiybl
	y8j268CsM6r8SqPK89Jql5bAhJZxtMSNtBiguZWzNpe3UOGr2OUCtFDu6cgcLzWx
	J90QX0C2oAH2PnsSFLjsC59qkkvX4dKReP8JOI639+rpZ686znUFKOiXcbl933rS
	rHjBO3icTzSSwF6ZdzL+iNxVmbGov+xLbe37GDK6jfliaLszFkZ0bz4bcWGbFmOj
	+2pGrlEelsjg9HOKuGahLSwcYDucIr8Nl1wq776HawnE5yRb0Bl8f12LxTLDBRJE
	6F40wT06m46cbatgGlY1uIb1kdsg+uNe7E6ciLDo7alYl3EyOtb3tp1xIw/uu2XQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh43a73g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:12:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDGCmio015273;
	Fri, 13 Dec 2024 16:12:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh43a73d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:12:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDFWlBq032734;
	Fri, 13 Dec 2024 16:12:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psxx0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 16:12:47 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDGCkHw53936584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 16:12:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC53158058;
	Fri, 13 Dec 2024 16:12:45 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F91458059;
	Fri, 13 Dec 2024 16:12:42 +0000 (GMT)
Received: from [9.61.68.160] (unknown [9.61.68.160])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 16:12:42 +0000 (GMT)
Message-ID: <c7717f89-65cc-4668-a3e0-ee042cdcd426@linux.ibm.com>
Date: Fri, 13 Dec 2024 10:12:41 -0600
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
        linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        ninad@linux.ibm.com
References: <20241212214927.3586509-1-ninad@linux.ibm.com>
 <20241212214927.3586509-2-ninad@linux.ibm.com>
 <f9d881b7-7301-476e-b281-0380dfcf0e10@roeck-us.net>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <f9d881b7-7301-476e-b281-0380dfcf0e10@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NzpH0gdcpRWbYIcxxx5eotGsIgESifCn
X-Proofpoint-GUID: OxreHfqoC1Ht6a91pdGiYTk7dSHkFhRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=718 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130113

Hello Guenter,

On 12/12/24 16:06, Guenter Roeck wrote:
> On 12/12/24 13:49, Ninad Palsule wrote:
>> Adding label files for fan and temperature sensors in the power supply.
>> The openbmc application dbus-sensor(psusensor) requires those files to
>> consfigure those sensors.
>> Note that prefix for temp label is temp[A..C] used instead of temp[1..3]
>> as dbus-sensor(psusensor) application calculate index based on last
>> digit in the name so we do not want to make index double digit after
>> appending page index.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>
> We are not going to fix userspace problems in the kernel.
>
> Guenter
>

Thanks for the quick review.

Sorry I am not clear on this. I feel that it is better to support labels 
for temperature

sensors and fans like other. Are you saying we should not support these 
labels or

I need update in the patch to support them better?

Please let me know.

Thanks & Regards,

Ninad Palsule



