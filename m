Return-Path: <linux-aspeed+bounces-1931-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3543C87FCA
	for <linux-aspeed@archiver.kernel.org>; Thu,  7 Aug 2025 14:11:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byTbT62bxz3cRH;
	Fri,  8 Aug 2025 00:11:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754575861;
	cv=none; b=hGE3q9eS2RGu+t4Y4LjtBPZREKgJvwRt9QYKX+Nj1tQt3uFWjr9HMDpCx6OcSu55ad/fcOBF2AOx6LX207RkzAoH2rELlEjaNTRCfb6WvwXxD+IaTj+PUKGJrVF6afGFAb+LrFvNFOC8naPKBG0oRnbNO1p5GfgA9E0MBRwYigYZZnpyHVmlEvPSKsNvjZS6u8/WR9llCBf0RJImTlEhlfZYFzIwcGSAY+UlXjf+evHZmiOcuV4iBi0tu7crmRcQY/m20k0znTB7e/hnXr//f1GVO7aafFucqBHcKUmf+UeHy/BZcv6b2yk84lObXiL9xBfby/iITtw7gjlosTjHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754575861; c=relaxed/relaxed;
	bh=uaVLiYspnYWDuI13bWNGEm5rQbPJSHbjCGX5H7vdxtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMpGND2P76M6sIvNPKyFwwgIvhdOav9HiC7qkYuCCo5UoNzUkkEkjmx5n5GhlRJ5qv5tHyySLp93f7otx490WheM6w3bwE0f11Ae+uIHLLWYfEP+1W9N6nQ7cRa9pU81SEcn4EKkq9hxfziqQmj76oFzfFbu+4Zez1H3nRFg8Nvhu5JBtDLy6xzlvAUtPPNR4HeweBfLmDJYrDk1y7KuvQaRyFWc3ejU7EzCt8hxJpq1eVf05+hTKfqQmiZzaJIhqd/vVNzXtw0Ok8TBkf0hDuJGvtg7sDa6XowNCT+ZWbZR/IH+OMpmTIftmvNTsrA53y2xhFFQS9ZikfhqgUcqXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mJBKLLYS; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mJBKLLYS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byTbS3NFsz3cPG
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Aug 2025 00:10:59 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577DYtvA009977;
	Thu, 7 Aug 2025 14:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uaVLiY
	spnYWDuI13bWNGEm5rQbPJSHbjCGX5H7vdxtQ=; b=mJBKLLYSXn/bhMBhPt1FhG
	aTEmzVBBRUk+FDweBa1KoY/yammJONzoVcbZVNKUVY2LTsgV+eS5h1CUf972DE8b
	1ZlQ4eQGeoDdtMZ8NvFhNQ1PNUwW6INaE88OGUMNVxEOhCrn+SRw/3UHrDb97Md+
	coHXluwpZZvLuXYL5xKhGXr6aYUtLLAkvsak99ouf4qdbVRLMTxCYscL5h81Im3Q
	dcXM6mVcYVYIilZe/4/j5tI5UankKZ8/7ERRcPU9GJV0XVqVk6iMsUBhS9VjvoBa
	hn3bnmJDds45/izA498NYZ1bHuCSLenGNTJeDmV+O/MsZlNHeSkVj2TD33pXnG9g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq612pbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 14:10:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 577DcdbB022699;
	Thu, 7 Aug 2025 14:10:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqgyfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 14:10:51 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577EAo9t17433284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 14:10:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5147358059;
	Thu,  7 Aug 2025 14:10:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 239C258055;
	Thu,  7 Aug 2025 14:10:50 +0000 (GMT)
Received: from [9.61.15.215] (unknown [9.61.15.215])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Aug 2025 14:10:50 +0000 (GMT)
Message-ID: <dd4a521e-f122-4122-af62-20ce113497ac@linux.ibm.com>
Date: Thu, 7 Aug 2025 09:10:49 -0500
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
Subject: Re: [PATCH v3 3/4] dt-bindings: trivial-devices: Document max31785
 sensors
To: Rob Herring <robh@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        andrew@codeconstruct.com.au, conor+dt@kernel.org, krzk+dt@kernel.org
References: <20250806184711.1882725-1-eajames@linux.ibm.com>
 <20250806184711.1882725-4-eajames@linux.ibm.com>
 <CAL_Jsq+JBhak=YS33tG=KFtbb+Ckz69s5Chz6daEUY0O95QOSQ@mail.gmail.com>
 <CAL_JsqKa6R2WQQsaJ-Rm8NwVAt7gk2yRSyjnZ44yYn1un2C12Q@mail.gmail.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAL_JsqKa6R2WQQsaJ-Rm8NwVAt7gk2yRSyjnZ44yYn1un2C12Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TLZo-HDNly3k3Yu_lJEb-DARaXrKBVMZ
X-Proofpoint-ORIG-GUID: TLZo-HDNly3k3Yu_lJEb-DARaXrKBVMZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDExMiBTYWx0ZWRfXzp9GJPLSuRpm
 UTXvHi+NyGwkwhhVKYDSBefHMYzX7s9/599Kbdm2u6/+mfutv4E2tz+XljAImSVoE+5yhBRNSbQ
 M6wsaWROtK60Z9WrW7byCNaZUcqCV6svi1cojyWbCVz3zoHLOdja3xrBe/T3bs/zNyjh5QTA7we
 p3Km6IrQZ1tOGuF7mgE0PjtojiwroVWY6/vY8G3QDUY+SqfL/mjop/gW2n2Fc6Ftibw/kHjld13
 yd70OZfWcvl15QK5btI7jfJRJNaEcYf3ND/WnpMVlzLOLV1i7XF8N4NydkDyVryB/TiZFObB0Lw
 nbYzobBC7/UFfBW6GdL2rsdgeh+y8XKipkmnhkXB5Uu8neSt9VgsKe/ZbP1xwwRyyfqJUbPVHst
 63c+9mkIwy2Ns45cREY2AjDcBPZEm3StCYRWMXrHZj0e/XZZsCisqHakQsLn0DpVOH4k5XmM
X-Authority-Analysis: v=2.4 cv=TayWtQQh c=1 sm=1 tr=0 ts=6894b3ec cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=jtbBNqsHAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rfOngFd2pyIVqCWdBOYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=RWaeYqt-Cn-VcsFsiLGo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070112


On 8/6/25 5:59 PM, Rob Herring wrote:
> On Wed, Aug 6, 2025 at 5:04 PM Rob Herring <robh@kernel.org> wrote:
>> On Wed, Aug 6, 2025 at 1:47 PM Eddie James <eajames@linux.ibm.com> wrote:
>>> Remove the old .txt max31785 documentation and add the compatibles
>>> to trivial-devices.yaml.
>>>
>>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>>> ---
>>>   .../devicetree/bindings/hwmon/max31785.txt    | 22 -------------------
>>>   .../devicetree/bindings/trivial-devices.yaml  |  4 ++++
>>>   2 files changed, 4 insertions(+), 22 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/hwmon/max31785.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/max31785.txt b/Documentation/devicetree/bindings/hwmon/max31785.txt
>>> deleted file mode 100644
>>> index 106e08c56aaa..000000000000
>>> --- a/Documentation/devicetree/bindings/hwmon/max31785.txt
>>> +++ /dev/null
>>> @@ -1,22 +0,0 @@
>>> -Bindings for the Maxim MAX31785 Intelligent Fan Controller
>>> -==========================================================
>>> -
>>> -Reference:
>>> -
>>> -https://datasheets.maximintegrated.com/en/ds/MAX31785.pdf
>>> -
>>> -The Maxim MAX31785 is a PMBus device providing closed-loop, multi-channel fan
>>> -management with temperature and remote voltage sensing. Various fan control
>>> -features are provided, including PWM frequency control, temperature hysteresis,
>>> -dual tachometer measurements, and fan health monitoring.
>> While technically the binding is trivial, I don't think this device
>> really is. It has got 6 PWMs and 6 tach inputs, a reset line, 2
>> interrupts (alert and fault?), and an I2C master. Not really trivial.
>>
>> However, better to have this documented as a schema than not, so I'll apply it.
> I take that back. You already have 'fan' child nodes, so this isn't a
> trivial device/binding.


That's true, I will add a proper binding.


Thanks,

Eddie


>
> Rob

