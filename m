Return-Path: <linux-aspeed+bounces-458-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BF4C02183
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 19:49:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX2sS4hVtz3d9g;
	Tue, 14 Jan 2025 06:49:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736797788;
	cv=none; b=WCj2LHrDb5ygbiIIB0fk1aRVgchDCkDIICwf9+oFAQBFd04i7+xmYi9uwbMd2/cYtsIEilT3i8dWEj8r9G/4R4pSeRky9i/fiDK8W1iufKTtKCg2S+pCtczl0Mi9CsGX9sUrGP5Grv3QSaeI7K3hTWwXnSLQxel20D87oqss017+TShMVXSFZrXVVKajfEziXzMf4Ya1bFPz3auo18fj6mb2OBXuS+Qxtzi6jQ8kZ44G4oDne9Us84BlxWfZMxXlOe7Ysp6s9vpNWu8x1rk+fuQWsk3sx7NfSIY0E3MYulo6zW6QJX6nHw7Io0kkaOM1KIllDyKZEFk6s4xRFq3wsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736797788; c=relaxed/relaxed;
	bh=d2GkHx4QTVyi0OT0e9WCdAsHm7vIJF8oUFztxZt5AGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWJ4IoUf0sgG/cwKo098s5RsxW6QE9kRq4okrPKRsHgy3gJyehZ7U2Due9QTJZnk3WmNRQvCnzVNra71GxV/e57cIsewA70Vd/6v5pX8TTTvdQZFvttacYnFzzvRoxkaR4rhsd3TlwdnLZvNVMmffC4fXL/SJ7Ky/Nj3+Hs+4nh+YceT0W+zcL9x3EK01aaqqoAO5N8y7bcQlqEoHjtRUAcBiCd3OzimLXzUUdNtO1Rd5D54ZX0irMLI0Jqq9tcA1VKX67uMGSQCECnRts9FOoX/QCe4sdyvnE3fFurXCBsfVHwlT2h6w8nBkQofz//S62UmFDXkw9RaVx8B6t3KyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QZAkYxeR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QZAkYxeR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX2sR2N39z3d9W
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 06:49:47 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE6RQH019827;
	Mon, 13 Jan 2025 19:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=d2GkHx
	4QTVyi0OT0e9WCdAsHm7vIJF8oUFztxZt5AGc=; b=QZAkYxeRygGqeVN9c7G6aC
	VQfBeFQJv+KDaQO5Evqaqn6I0e2OBBZ93ZR7D9tJGrT4eBkfZEus43CciAZxY+K+
	c8jTAB3BWVWfWITreEC5esAhLAAQF/ecC0k04NM4/ORRrIaArzY+KodddlSRwZ4l
	Wde9jcgksdLOfF7k+WATvcpalpCmm8fkq5z2i0o0UV8pesTWgQN2Bq66/URHNOHi
	1cmPbw58l9VA0yL1L0lqZhQykPRy8BSq6PeScZJy3qVC3WQcb2l+0A8moGCi5Oxv
	48awYrCyJZPIaLhDdTkocp5Hs0sGCebzn8cQY+/uk2hxNuUUvYLkZT+v5Qau1Vhw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a59hmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJnDAw017868;
	Mon, 13 Jan 2025 19:49:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4454a59hms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGd9gK016994;
	Mon, 13 Jan 2025 19:49:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fjyrny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:49:12 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJnBIO29622810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:49:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 165625805A;
	Mon, 13 Jan 2025 19:49:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6136458051;
	Mon, 13 Jan 2025 19:49:09 +0000 (GMT)
Received: from [9.61.105.40] (unknown [9.61.105.40])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:49:09 +0000 (GMT)
Message-ID: <99645919-6756-4442-ad2f-a9b353da22c8@linux.ibm.com>
Date: Mon, 13 Jan 2025 13:49:08 -0600
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
Subject: Re: [PATCH v3 01/10] dt-bindings: net: faraday,ftgmac100: Add phys
 mode
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, conor+dt@kernel.org, devicetree@vger.kernel.org,
        andrew@codeconstruct.com.au, kuba@kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        andrew+netdev@lunn.ch, eajames@linux.ibm.com, minyard@acm.org,
        krzk+dt@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, edumazet@google.com,
        ratbert@faraday-tech.com
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-2-ninad@linux.ibm.com>
 <173652497637.2952052.6627595246829829775.robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <173652497637.2952052.6627595246829829775.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: e2UR_H-XhwWAH3iBg0WOCRUvriLik3My
X-Proofpoint-ORIG-GUID: W526mhYllqjPLt3wkW7aqjCd7n_jLJWp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130156

Hi Rob,

On 1/10/25 10:02, Rob Herring (Arm) wrote:
> On Wed, 08 Jan 2025 10:36:29 -0600, Ninad Palsule wrote:
>> Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
>> document them.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml | 3 +++
>>   1 file changed, 3 insertions(+)
>>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for the review.

Regards,

Ninad

>
>

