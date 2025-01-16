Return-Path: <linux-aspeed+bounces-501-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A220CC02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 14:30:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYldk2C3Wz3cbl;
	Fri, 17 Jan 2025 01:30:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737037834;
	cv=none; b=ZxJ0jdRj9EPh9pBkXTPs1k89v9xg+19t235Ez/kNzAarczk1AizmT2Q2AU/updNnYiXzOmEoLhchX9xil3MdEVx/ouYDfWVVUOz70WqW+k/Cx2BKeCKMeecOZ5odQheF+FSHlynyBfLTcgORTkpZuXoZLvYMY5smyHgS/qXhJxTsO+AOiGNF4g0syupBlXkhhjGLG/vN2+sfZivWT1880QVpFiyctUoOBirFpX5/ifJCKIffHsaeHH83QUzBk492yLtJPA/DXRx9J8OMh8scqeDcUGCsDZ95r3QFUL1e75gss91BrizIl7o6ZPYYAf4EPw7CWsgugqQZ8amuXO2ldA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737037834; c=relaxed/relaxed;
	bh=pHS0Fn61rhNPulYZt6CO+SM6wBYoyMhn/IvaB4skFsQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=GXPzGn+oJUUWPvIgMhjf1xJRkssDSkuvLgsYV5cHdAAuk+zGJSrEqJJGeFG6gWLEudNOtsOM1R0glXdecRCVaq3mSG19DXKaDJtFIMP+oMzYqM8tOGAZa8PT1BI+x+5dE7iUrGnztv/6Y1+Qt8tGCs+Zhf0Rpaq5wsrVpauUcSwNIk+AxGCJ65SPNiEJJMIrQJGtouHk+FnWHmAXMLxuPh9DkKDt5W3xLuTRJryzl2sOLrPFRAC+OaMu6lMsqShGVDD6e7NRFxVboFsd6sVGA4WMZnimhGn3qFylyMQh63ck+hmMRzQ+XnbpqxBEopYeDtsLwxlH3tGwGR4/I6+lTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tiUus4CQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=tiUus4CQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYldj2X62z3bhD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 01:30:32 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GCMPgY022802;
	Thu, 16 Jan 2025 14:30:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pHS0Fn
	61rhNPulYZt6CO+SM6wBYoyMhn/IvaB4skFsQ=; b=tiUus4CQ5KOVLwSSpt3KQv
	CGxavg6M6mrjTVc7bcMNJ6tcQrm3z7feowhOwYn6P4awZtD/QgouqNGCW4S8yIUK
	e3RjO21Kbw87oyye2EoNwS/rcduQQw5ZabENsZo5eMnZTGC7hz9At+f+tbALyUSd
	CoqjWEyTe5wMgbRqZ4ddrs/7W2MhH/9fMd4xHbzdKV7yF/31NkTTnEgeH304q3sg
	luEcvJCBPcdo2gbzixy4Svok+huIP3/cBLMebu/GDPbZ0dOV16q3SSOopqZwlydo
	FEGtNMoOulQRG5x4aua/N+7Xfi7GFRl+tPH8Vknh1kJ2oDw8i0ML3Zff4sEnIreQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub3j3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 14:30:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GB4bAl016490;
	Thu, 16 Jan 2025 14:30:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1wux1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 14:30:15 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GEUEeH29688478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:30:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8523158062;
	Thu, 16 Jan 2025 14:30:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D161458055;
	Thu, 16 Jan 2025 14:30:12 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 14:30:12 +0000 (GMT)
Message-ID: <ae14daf4-c7fe-4fcc-89cd-5d1d8b320193@linux.ibm.com>
Date: Thu, 16 Jan 2025 08:30:12 -0600
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
Subject: Re: [PATCH] ARM: dts: aspeed: Align GPIO hog name with bindings
From: Ninad Palsule <ninad@linux.ibm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116090009.87338-1-krzysztof.kozlowski@linaro.org>
 <cba3c5e0-624b-40a2-8b52-8d07604676a1@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <cba3c5e0-624b-40a2-8b52-8d07604676a1@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rJ3dDbNz14S5BMjlPMGQE_49alAp4k4J
X-Proofpoint-ORIG-GUID: rJ3dDbNz14S5BMjlPMGQE_49alAp4k4J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=726 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160110


On 1/16/25 08:18, Ninad Palsule wrote:
>
> On 1/16/25 03:00, Krzysztof Kozlowski wrote:
>> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
>> to fix dtbs_check warnings like:
>>
>>    aspeed-bmc-lenovo-hr630.dtb: pin_gpio_b5: $nodename:0: 
>> 'pin_gpio_b5' does not match '^.+-hog(-[0-9]+)?$'
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  2 +-
>>   .../aspeed-bmc-arm-stardragon4800-rep2.dts    |  4 +-
>>   .../aspeed/aspeed-bmc-asrock-e3c246d4i.dts    |  2 +-
>>   .../dts/aspeed/aspeed-bmc-bytedance-g220a.dts |  4 +-
>>   .../dts/aspeed/aspeed-bmc-delta-ahe50dc.dts   |  2 +-
>>   .../dts/aspeed/aspeed-bmc-ibm-bonnell.dts     |  2 +-
>>   .../dts/aspeed/aspeed-bmc-ibm-everest.dts     |  2 +-
>>   .../dts/aspeed/aspeed-bmc-ibm-rainier.dts     |  4 +-
>>   .../dts/aspeed/aspeed-bmc-lenovo-hr630.dts    | 46 ++++++-------
>>   .../dts/aspeed/aspeed-bmc-lenovo-hr855xg2.dts | 68 +++++++++----------
>>   .../dts/aspeed/aspeed-bmc-opp-lanyang.dts     | 14 ++--
>>   .../boot/dts/aspeed/aspeed-bmc-opp-nicole.dts | 10 +--
>>   .../dts/aspeed/aspeed-bmc-opp-palmetto.dts    | 40 +++++------
>>   .../dts/aspeed/aspeed-bmc-opp-romulus.dts     |  6 +-
>>   .../boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |  8 +--
>>   15 files changed, 107 insertions(+), 107 deletions(-)
>>
Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>

