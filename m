Return-Path: <linux-aspeed+bounces-460-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B51BC02183
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 19:51:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YX2v90f7fz3d9W;
	Tue, 14 Jan 2025 06:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736797877;
	cv=none; b=K+HR5fMESXsnFHx3XoofuQl9xuHjaSCxwG6SEhd/XIbobbsC1LGWTDbZ+LRh0La+NZR8vNTW6s4dxzQ0q6J0duGKWiA+Ma5fVeYhHWJco7/5aRY/AN1HYZzvOp+R29lRfeuGt0bpbXpU/6ppEb1lVbk5aOdbvMxeap4LWBTv4+0T1StWnmLm898JFPY7qtcjPx3sECiwdvwIko1G+RQ+oe/WD7sHlpDJY4Pk3prqskp0f33p5UwBircqS9uK0fxslL6tT+zcmJ2eX7E5NetcotziWx21XaMDfOY6VCW3L9azQT9ZappNmD9ilIBeLNHeAYAWHnfBz6/slXzBc6fjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736797877; c=relaxed/relaxed;
	bh=raLVazOTH2YUlyxL7EXDEtYhqzQORGC8oK0/B3jL/r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jz2uPc/dgxnXLbg8cEi4UkRrpxXBiHDmEJCFl3qlUKW+KPDzAG9fdsuiM+Xdx/xnCYuY/n3ZV8ofRrW/WMTS5k8+2GlRbWu02PZLYKP4myHRXYWgbT0r+4pnFYtaagh/HxyyXpyVOn+yXw3bdPnrRWUi8iNclkvLbR5T/XyjipdNWxSBIVb9TRFDvY1g9U56mN39Bav3XsuX64VOGYhhAlwzmqpMtgf8+SYm9cnwQMMGIT/RlkEYv0xsczry+I1Zj6KQlky+sqXnKXb6s279lN02SCBQ0uwDSsGU4E0vn2VJO0jtyxaB84Ir7a/WpH3ri59lAok1pkl8sHozUYtZmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QK08Vscl; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QK08Vscl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YX2v802sXz3d42
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 06:51:15 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DF7OBK003096;
	Mon, 13 Jan 2025 19:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=raLVaz
	OTH2YUlyxL7EXDEtYhqzQORGC8oK0/B3jL/r0=; b=QK08VsclLq2CSJ3yGljUqE
	nt2Zcd+bdQ1P/e/1DtTX2M4O3njriADKQRinqVp5zKwKhDyFb/dIqxBotxDTV1IM
	XWCmmfncK6SpUEelMr7zNQiPyB6JcmvJJdaV+ROwlfgzMPaj4QqSYbMjeJE5faHI
	YqrIu4g3j5lc3VTR66iUnKI7w1OR2Pxkjk2Cy27O1MdWCpRzLPbJuuQ7PXim0o9c
	RE52WlwrqdOlc88d++PiZLvI0nNGO3P6fHQBcDOVdk6cju0lP0kVNLojCFBTQfm1
	9ujyM4IAAL/Jfz8MBP9RowtQ+1fy+A29VwlzN+sdCCNX+aN/dgxTcJ964aCiI6Kg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uaguw0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:50:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJgqZt020111;
	Mon, 13 Jan 2025 19:50:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444uaguw0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:50:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DGU2DS007385;
	Mon, 13 Jan 2025 19:50:42 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ymyu32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:50:42 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJofVP32244322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:50:41 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D51735805C;
	Mon, 13 Jan 2025 19:50:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07FBB5805A;
	Mon, 13 Jan 2025 19:50:39 +0000 (GMT)
Received: from [9.61.105.40] (unknown [9.61.105.40])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:50:38 +0000 (GMT)
Message-ID: <38f9a51d-0116-4ec4-b515-26038f91659b@linux.ibm.com>
Date: Mon, 13 Jan 2025 13:50:38 -0600
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
To: corey@minyard.net, Rob Herring <robh@kernel.org>
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
 <Z4Fejhd_qPfuVLiw@mail.minyard.net>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <Z4Fejhd_qPfuVLiw@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -e7S3whLGUPEjVKglQj4-uLg1hX1hsz0
X-Proofpoint-GUID: UTKY78W8byq0kSk5ICb8m0CyqtOykedE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501130156

Hi Corey,

On 1/10/25 11:53, Corey Minyard wrote:
> On Fri, Jan 10, 2025 at 10:07:13AM -0600, Rob Herring wrote:
>> On Wed, Jan 08, 2025 at 10:36:30AM -0600, Ninad Palsule wrote:
>>> Add device tree binding document for the IPMB device interface.
>>> This device is already in use in both driver and .dts files.
>>>
>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>> ---
>>>   .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 44 +++++++++++++++++++
>>>   1 file changed, 44 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>> new file mode 100644
>>> index 000000000000..a8f46f1b883e
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>> @@ -0,0 +1,44 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: IPMB Device
>>> +
>>> +description: IPMB Device interface to receive request and send response
> First, thank you, this does need to be documented.
Thanks for the review.
>
>> IPMB is not defined anywhere.
> Indeed.  At least reference the spec, but better do that and provide a
> basic description.
>
>> Which side of the interface does this apply to? How do I know if I have
>> an ipmb-dev?
>>
>> This document needs to stand on its own. Bindings exist in a standalone
>> tree without kernel drivers or docs.
> At least to someone who knows what IPMB is, it's pretty clear that you
> are saying "The i2c device this node is in is on an IPMB bus." However,
> to someone who is not, this is all a foreign language.  This definitely
> needs better documentation.
>
> Why do you have a "reg" property?  I don't see it referenced in the
> driver.  I assume that's the I2C address, but that's going to be the
> same as what's in the containing I2C node.  I don't think it's
> necessary.
>
> -corey

I have improved the documentation in version 4. Please check.

Regards,

Ninad



