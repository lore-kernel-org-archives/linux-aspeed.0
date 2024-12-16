Return-Path: <linux-aspeed+bounces-253-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA0BE7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 18:02:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBnpr0sjlz2yNt;
	Tue, 17 Dec 2024 05:02:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734372164;
	cv=none; b=bU1E8fjWcyZIIG1V8HssplLVz+p49VMzo6+p88xy5Vhcq9H63aDw3sWhE7FhLkV2+uVok5dbSZru5ae5/iBQWPiI7lzK67FTqdUKTte0hfd7fwiMXZUbvyUcKTWcP39EPBDv7Mrpgzmc+4f9wArI6kU79nGWIdH+T6m4so5dIXAk+VNBZA9XAww8uC8X9P9jZFPE4jxp5IUj9JWiTKxXbwmrLhtUs4srGRX8c8R+O2EEp0ksrVF02AGUHMnMmAOY29HU8GgHPkhA/CvHLI+gL9K7Z0KRjSq4JDnPtFg83tkzMS5Fm0ZJrw+y2F3HPlfycK9iOtbD5JdBVgL18D6NDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734372164; c=relaxed/relaxed;
	bh=JFdd6ieB8cMiWeGhyy5miUVzioTUAqIBJxNvKJbMm90=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gwziri7SrLELPiA6nDWnAGGdKMEtaYtdRU6/LKTgKbHuwb+JRAnD058jIK/2d6iP+qFlqy77YafS8P2DJD1YzyIrv8eye0bpjncAGUKukli2XQkIv8YQ3XbJcVW+wqtAjkuRPcXpPoyKGTZei74L+U/HkmpsRtu8OjTm2HqWLFRZqI4WJB8XRf+xkkyIOoV6RA4YU6NDJjFKMsCatKTfVn9c9Zc5321DQ8oxQ0hiJKngbDBKbN2trwdCuB71dBJge/OsNbkVealkpsdXrJFF+MZqqPRfD9X2lvQmgUEYoAwpEoKYMWGQhCPE+MpPyUx+L8w1AtrUFEAtgAenK3o4aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HYcbxUAw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HYcbxUAw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBnpq1JX5z2yLB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 05:02:43 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGCr3kx008928
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JFdd6i
	eB8cMiWeGhyy5miUVzioTUAqIBJxNvKJbMm90=; b=HYcbxUAwzBEpjbs0oG+cmd
	AhywXyVyFvFCdbMAgH4XPfpl3rhZcfrSvTLH5uGo9IhjF9Z3v8jSDlGK1PWzt8c9
	8WXfVIsrtsZcPt9dXep+OOpn2nT0Ds4JSqv+zBxHQ2r3ITvgyowiHqqd9+TOa9vz
	xN10W9404fUMBHkW3RE3lllLAKO/jeC1YQv/uaFtUvDl7dxlYJFZdFM0cLXRn23z
	81980yGxNQ1ZwYuWYW3ezMALWgdNzoSDLi4v+IirRpxrUyZI8sYyeHjC15oNohzZ
	jbQXD5aDHyg3uXiDFfGMcvclQ7UZlNgZCVzInTK8OI/kvHpduHsqwV/hKIoFK4nQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43j98h4nmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEp3nE011260
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:40 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43hpjjxvj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:40 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGI2dbE20644476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:39 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91FF15805C
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F54358054
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:39 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Dec 2024 18:02:39 +0000 (GMT)
Message-ID: <12183b6f-4ed2-49a4-baa1-fe718c171e00@linux.ibm.com>
Date: Mon, 16 Dec 2024 12:02:39 -0600
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
Subject: Re: [PATCH v1 3/4] dt-bindings: hwmon: intel,crps185: Add to trivial
To: linux-aspeed@lists.ozlabs.org
References: <20241212214927.3586509-1-ninad@linux.ibm.com>
 <20241212214927.3586509-4-ninad@linux.ibm.com>
 <au4mmpxa6tbznu3pcxeu7tri4elvcoyy7l5m5ujdpj7ah3xqrz@ule3ymdiisyj>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <au4mmpxa6tbznu3pcxeu7tri4elvcoyy7l5m5ujdpj7ah3xqrz@ule3ymdiisyj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YYuWRFBYWEByiuv3lHkogYjyc_2HNGiH
X-Proofpoint-GUID: YYuWRFBYWEByiuv3lHkogYjyc_2HNGiH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=847 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412160150

Hi Krzysztof,

Thanks for the review.

On 12/13/24 05:08, Krzysztof Kozlowski wrote:
> On Thu, Dec 12, 2024 at 03:49:02PM -0600, Ninad Palsule wrote:
>> Add INTEL Common Redundant Power Supply Versions crps185 bindings as
>> trivial.
> becuse they are trivial or you don't care? Some broader context would be
> useful here.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

Yes, I care for it. I have updated the comment. It is trivial because 
device tree only need compatibility string.

Thanks & Regards,

Ninad Palsule

>

