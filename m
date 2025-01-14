Return-Path: <linux-aspeed+bounces-480-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9B1C02183
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Jan 2025 22:08:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXjty6dmfz3bSK;
	Wed, 15 Jan 2025 09:08:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736892506;
	cv=none; b=L0MxKC2waND2iIj14CP+Cdc4dYia6Rz0EejpJXi0zwwM39v1OZkOYDta1G3TLhPLr2Wo9Hc+Eknl/7LNePeuknWbUuld+Kg9N5KTte5rzqbW7WEEM8S8884UclWmP2NUBgZk4efK7wNLl4hsKDz/RgfIUh9D7RVHUM5nqws1isbXQnptBR/Qjb3VkjryhFItGr+C0XxWqsDdtp2RfsaASMxrq4w0/3TGz+H9fVsUQzcRPsnO+dNnaOMBDOwbBOF6RqpeBFriyKIM75MjLL1rgsPoABXds7DkuVr0QkaErjVPvTAjmAwPKEUCKbsHA62gn4VwzA28DwCTF65ejHO/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736892506; c=relaxed/relaxed;
	bh=H9FTzMRGKReVo8rRd51mMDR1WUTZm8UGLKzKl1Ziuew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJPITqF62xffWiXIvkQZjCxo+uKF5yG/D1fgd9969nK8lvR1wXMxPRmNKlhzZuchPOyo7jeyepYBhOc0gxPU/YX6jj8xIub7sJh2oy0q0UcYPj/7PECY13LjGYsVTLldcdfFSK4GDGiXzgU5+ksyzgsorwDSzXzbkeG0TijLaVaqGn1WeFZ0whUq4BW4DcGYGYro//y5ono8cgCQTeGJzyqIAbFzdwNKjSut3j/QBVtUOS5TzTc2o/VKtehK+2WDI0Kk8YsurP5PtA9h7CEhIQV6YlBJDvrsbOPoFQWiu7MjHr2TjbHt4f1PUSdDF28hqPcv8zQaVsZV9szIlbNgug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rzD4kMaQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rzD4kMaQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXjtx5wXnz3bSJ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 09:08:25 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50EFUS7u020161;
	Tue, 14 Jan 2025 22:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H9FTzM
	RGKReVo8rRd51mMDR1WUTZm8UGLKzKl1Ziuew=; b=rzD4kMaQ+5YxCEChLLPEXm
	W6guXK23lS9Fn9Uv4NQ5UaODFoctFHzatf8ruqrMX2XLg5+HDXTB2DLjyTnk3Q3I
	J0Lb5vsOjO+5V/cl3pxC71UwDhEhnZ8XbMtJX4mnotc7f0DciITaDpaTqy4UyNp0
	5Ki5BM8U+xXaP/wqhOjG79+l2MmrnitWTUpjS6FzrXCb1HslWN2V6uMJumGIWmtc
	+HTvzG7Wnf5DIjDpsdaHyL942COFy+2uKZ9ms72AlN59FjmFiLypqOa2CiIwIFnn
	35yb4UHbo8OoKUTAgGPWfavgjGzu3WJd5nrw3dgl9prok8M2kmpNyCB3hmEz4Xlg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445tmghpby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:07:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EM7pTd011791;
	Tue, 14 Jan 2025 22:07:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445tmghpbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:07:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EIvnK6001110;
	Tue, 14 Jan 2025 22:07:58 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456jw2r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:07:58 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EM7vp428050170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 22:07:57 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7373558054;
	Tue, 14 Jan 2025 22:07:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43E5C5805A;
	Tue, 14 Jan 2025 22:07:56 +0000 (GMT)
Received: from [9.61.120.113] (unknown [9.61.120.113])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 22:07:56 +0000 (GMT)
Message-ID: <6eb91fb6-eac9-4386-98c8-196ac3d51e7b@linux.ibm.com>
Date: Tue, 14 Jan 2025 16:07:55 -0600
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
Subject: Re: [PATCH v4 2/9] bindings: ipmi: Add binding for IPMB device intf
To: corey@minyard.net
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250113194822.571884-1-ninad@linux.ibm.com>
 <20250113194822.571884-3-ninad@linux.ibm.com>
 <Z4aUyX8g-JprzLpd@mail.minyard.net>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <Z4aUyX8g-JprzLpd@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C0WHlT9TpC8xSLH_NeldTho0i_3p3X2Z
X-Proofpoint-ORIG-GUID: isMDwKsHEYgDk1WkKrzf-SSVOFPHI0hO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140166

Hello Corey,

Thanks for the review.

On 1/14/25 10:46, Corey Minyard wrote:
> On Mon, Jan 13, 2025 at 01:48:12PM -0600, Ninad Palsule wrote:
>> Add device tree binding document for the IPMB device interface.
>> This device is already in use in both driver and .dts files.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   .../devicetree/bindings/ipmi/ipmb-dev.yaml    | 55 +++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>> new file mode 100644
>> index 000000000000..136806cba632
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ipmi/ipmb-dev.yaml
>> @@ -0,0 +1,55 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/ipmi/ipmb-dev.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: The Intelligent Platform Management Bus(IPMB) Device
>> +
>> +description: |
>> +  The IPMB is an I2C bus which provides interconnection between Baseboard
> "Baseboard -> "a Baseboard"
Fixed.
>
>> +  Management Controller(BMC) and chassis electronics. The BMC sends IPMI
>> +  requests to intelligent controllers like Satellite Management Controller(MC)
>> +  device via IPMB and the device sends a response back to the BMC.
> device -> devices
> "a response" -> responses
Fixed
>
>> +  This device binds backend Satelite MC which is a I2C slave device with the BMC
> You use IPMB devices on both the BMC and the MCs.  The sentence above is
> a little confusing, too.  How about:
>
> This device uses an I2C slave device to send and receive IPMB messages,
> either on a BMC or other MC.
Changed
>
>> +  for management purpose. A miscalleneous device provices a user space program
> Misspelling: miscellaneous
Fixed.
>
>> +  to communicate with kernel and backend device. Some IPMB devices only support
> "kernel" -> "the kernel"
Fixed
>
>> +  I2C protocol instead of SMB protocol.
> the I2C protocol and not the SMB protocol.
>
> Yes, the English language uses way too many articles...
>
> That is a lot of detail, but it looks good beyond what I've commented
> on.
Changed.
>
>> +
>> +  IPMB communications protocol Specification V1.0
>> +  https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/ipmp-spec-v1.0.pdf
>> +
>> +maintainers:
>> +  - Ninad Palsule <ninad@linux.ibm.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ipmb-dev
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  i2c-protocol:
>> +    description:
>> +      Use I2C block transfer instead of SMBUS block transfer.
>> +    type: boolean
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        ipmb-dev@10 {
>> +            compatible = "ipmb-dev";
>> +            reg = <0x10>;
> I'm not sure of the conventions around device tree here, but the reg is
> not used in the driver and it will always be the I2C address that
> already in that node just one level up.  It does not serve any purpose
> that I can see.  My suggestion would be to remove it.

There are some boards already using reg so I will not be able to remove

but I have updated the example which reflects what those boards are doing

  which indicates that node address is ORed with I2C slaved address.

Regards,

Ninad

>
> -corey
>
>> +            i2c-protocol;
>> +        };
>> +    };
>> -- 
>> 2.43.0
>>

