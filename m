Return-Path: <linux-aspeed+bounces-519-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800B8C02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 20:38:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYvnw1Ghjz2yvs;
	Fri, 17 Jan 2025 07:38:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737059892;
	cv=none; b=YeXnYT8b4nShJggOy7A0RPFPPVWPl5ipmfmzRl9+2GjvHz3UYCQlkbhY1W4mRdb/VUX11+fX0iOmNMOUN1YA4lXaqidq9krgAYpbaecy6JaVkLPL70Hx8MO/g9vfYTWk3tIaHwXG2ZyooC9bPZqrcR6FXUkLvMIF+kIuwCEm0ObrxMdGf35sgqPRGzSQ+uyAmzGrouRyMoX0/Bv23C+D9pUKj+czfsA8Pqj24oA2N6gVTxjylLq4UtGjqMgSJniWzPO1JwKZKwElnjIwsX0w4P5YgHrCtjcTZ3tY6Bn8M0EKasgVLorKRNrchVHjgslEJXO6beTtCbY5nfHxy42f+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737059892; c=relaxed/relaxed;
	bh=XOwUUj+9Al5+mspF1UWIyD+W6CPpDiMR74J1EVLvCzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJMImq3MYAJlC0r0r+GTMqPrUW1qY1Buqq7gNwO5ZdfyHglshL8e8joHDA4ykUSKl1Pi1vvAwgZpmKEXUo/1V97gjcoO3biRflNJ6Q1JfF3pL5kGqZvgyLFSlTeAZppIKtsHxy87bKYXHz8QthRlMog4moxBv+WyNUu0IgolIjw/7kYH1ueE8zCo+SIxkd+DGPTO4zh9A1AUwp3saZfzTiAz9oV3fxVveWeIfKXSQdzv1aXa62KeMn6ETenfZ+jgZJ1gR+mtroDIT/hUazwuE6CHAfcADbQ40cVlutKnLj2K9V5bOC7YOwVWAym3i8S8IPOUY/XkUbNh9SKdmTE0oA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ek/0N0/d; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ek/0N0/d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYvnv3D9wz2ypD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 07:38:11 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GEN71W004842;
	Thu, 16 Jan 2025 20:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XOwUUj
	+9Al5+mspF1UWIyD+W6CPpDiMR74J1EVLvCzs=; b=ek/0N0/daEP783QrNb5L2O
	VajxIFEIdCTOl48UZCAc7XcL+4Mkjh6yRTvCUVJhAK+fQf/7JmQSaHq+daxaWeRS
	lTk9TnZAiuiDq4ghdSRJuBI/mP92Ovc6joOGhmZLomMvRh4Sq0fL0zyiciaC5oBd
	P2E+cl25X9GecJTjdD9+/+B1h5sGezk73se5vK9SBbSlw7roVgCcOAhjBK8HQhT0
	l5wgAX+mih2CVThNsfeV3CKWay2nQJ9EYRgjF1oSA4h/2aV6kgbLbnFdOLeFMmXT
	yqTiI9Q4rI+J99/VsHm1cwD/3iF2+TU6i/BSdy/jVPlHZvKvko6JdZ+nwiwgXnyg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhcqg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:37:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GKXJSW010145;
	Thu, 16 Jan 2025 20:37:46 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhcqff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:37:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GHdmgL007519;
	Thu, 16 Jan 2025 20:37:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynfmw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 20:37:45 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GKbi2L24445642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 20:37:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A3658055;
	Thu, 16 Jan 2025 20:37:44 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72B075804E;
	Thu, 16 Jan 2025 20:37:39 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 20:37:39 +0000 (GMT)
Message-ID: <c61740c8-8dd3-4d59-8553-1dea4cbd5c93@linux.ibm.com>
Date: Thu, 16 Jan 2025 14:37:38 -0600
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
Subject: Re: [PATCH v5 03/10] dt-bindings: gpio: ast2400-gpio: Add hogs
 parsing
To: Rob Herring <robh@kernel.org>
Cc: andrew+netdev@lunn.ch, pabeni@redhat.com,
        linux-arm-kernel@lists.infradead.org, edumazet@google.com,
        joel@jms.id.au, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
        andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org,
        eajames@linux.ibm.com, minyard@acm.org
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <173689907575.1972841.5521973699547085746.robh@kernel.org>
 <35572405-2dd6-48c9-9113-991196c3f507@linux.ibm.com>
 <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CAL_JsqK1z4w62pGX0NgM7by+QRFcmBadw=CRVrvF2vv-zgAExg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pDZnXta5jIEiLEPhuvleI218uMy8Px8J
X-Proofpoint-ORIG-GUID: c5p-lEQ3kr5JODh2EUhlema0DIXGbz0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxlogscore=547 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160151

Hi Rob,


>> I am not seeing any error even after upgrading dtschema. Also this mail
>> also doesn't show any warning. Is this false negative?
> 
> I believe this happens when a prior patch in the series has an error.

Thanks for the response. I have sent a next version.

-- 
Thanks & Regards,
Ninad


