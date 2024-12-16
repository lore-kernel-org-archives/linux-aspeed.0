Return-Path: <linux-aspeed+bounces-258-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B75E7717F
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Dec 2024 22:28:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBvhz41RGz2yD4;
	Tue, 17 Dec 2024 09:28:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734388083;
	cv=none; b=J5/hcK79rB3d0B1I3wBKKy8AfEm/R8zT1jVFAXLeL/axCYyDfWG25eToS8IeLY7W9deATBtkEytvhC4X66WSXFcM8Pho9UmFJLf2M4GrqQAG56CFNZLMw51dNbdGOIPX+Wdj9DzT46vzCh8IR49uLl8af6Vxfw3EI+3Og1HL8B0ZoJHYVooxKFbxyfD9NaC+0qXFpgCmnig+hoCpr7s3iOLAlAxAA7oC2pDG8u0/A3z8uDlYeLVIj+YSapHHuSuvCRdHTTUK8pDT4ft0IWRR9Mvm3aoTCB6eBLtELcH59iGX0OUu+vhUeJNuiNmyvmx18+b2QSPN75k5ZCZ9hSb52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734388083; c=relaxed/relaxed;
	bh=XexS5EE03A2kFOO1RC4vOyWubIQY+mIHYfLpVdjzVl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Dj5P09VmCjus4nNKmUvbfGOGvvNUG2tKCP1h1qTEbpaQ7jHls6ijJOLwaUV6km1r9hKq6XvtgkaviZkhbGnzB+V4GOxfywpIEBS59/4n5ARY3u2oboCZ51muFQ2vUqY/f11pBxLHBuE0MS+/1VUOFpgtvUPqZJay4fZk9198HCnR8FIMoyNrXhaRnKK+3Fk4DtcKVCaInXw03/z55XgXoZOjtxOL+wc7J4i2+L+ZaUNIj4O9eLXwOMzjyv7dtNb+jxPjrmu4xJpUlR1VPcxdztM8dSc83+JQRIHjP9FePhd0fJ22rf7tD9kFXQMAcCWKekZ+qfT2Badtuk1kVnmlcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nyb8/uIg; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nyb8/uIg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBvhy2NDRz2y8d
	for <linux-aspeed@lists.ozlabs.org>; Tue, 17 Dec 2024 09:28:01 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEhWhn022843;
	Mon, 16 Dec 2024 22:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XexS5E
	E03A2kFOO1RC4vOyWubIQY+mIHYfLpVdjzVl4=; b=Nyb8/uIg0lov8QWWAhi6ym
	fJhH8v7Tr+FdNv8NbmGcSlBnn0wkGgelfj0TeTmav5XbgPNaw0PfQDBEj1Uk64Eu
	TvbnaK+lzqiUtgAgvJ3w9kNhzhA+h3uMRWdQe23k4WjA5iOecK1QVgxCOvNGJIL8
	OMjIc03td2D6JzzyLXg/ilRiw05VL4i1mLTyi3QpyUFdq4SNzyo99cAVQ4CzIDYs
	5/dZgTPF2qQyc2vMDZre7UzzgOenAPNP0H2nhnEiG31kHwnXfUbMTehMBOHQcK9J
	9R80g6sBlbt9ZXzec8P3PW7mtLuBNaWghNPBNf0tmL5XgJEJdGppbJqeNcCTmOOA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgw1v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 22:27:41 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BGMBIIP021984;
	Mon, 16 Dec 2024 22:27:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43jcpgw1uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 22:27:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGLDT7L014340;
	Mon, 16 Dec 2024 22:27:39 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqy04sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 22:27:39 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BGMRcYI18219554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Dec 2024 22:27:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A4A95805F;
	Mon, 16 Dec 2024 22:27:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD8BA58051;
	Mon, 16 Dec 2024 22:27:35 +0000 (GMT)
Received: from [9.61.165.36] (unknown [9.61.165.36])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Dec 2024 22:27:35 +0000 (GMT)
Message-ID: <d75e72a8-6bd5-4929-a8bb-e1b13fd7d3b8@linux.ibm.com>
Date: Mon, 16 Dec 2024 16:27:35 -0600
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
Subject: Re: [PATCH v2 0/4] Add support for Intel CRPS PSU
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
References: <20241216175044.4144442-1-ninad@linux.ibm.com>
 <c64bb634-46d4-486a-8743-699775326058@roeck-us.net>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <c64bb634-46d4-486a-8743-699775326058@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GST_I0viN8YQt3jOs4JP1EhREbfu_C3_
X-Proofpoint-ORIG-GUID: Y5LYT8Ng54jd9v0EuHcH24-ljTCPN46c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412160181

Hi Guenter,

Thanks for the review.

On 12/16/24 12:48, Guenter Roeck wrote:
> On 12/16/24 09:50, Ninad Palsule wrote:
>> Hello,
>>
>> Please review the patchset for Intel CRPS185 driver.
>> V2:
>> ---
>>    - Incorporated review comments by Guenter Roeck
>>    - Incorporated review comments by Krzysztof Kozlowski
>>
>
> That is not a useful change log. Please describe what you changed, not 
> who
> asked for it.
>
> Guenter
>
ok, I will improve it in version 3.

Regards,

Ninad

>> Ninad Palsule (4):
>>    hwmon: (pmbus/core) Add PMBUS_REVISION in debugfs
>>    hwmon: (pmbus/crps) Add Intel CRPS185 power supply
>>    dt-bindings: hwmon: intel,crps185: Add to trivial
>>    ARM: dts: aspeed: system1: Use crps PSU driver
>>
>>   .../devicetree/bindings/trivial-devices.yaml  |  2 +
>>   Documentation/hwmon/crps.rst                  | 97 +++++++++++++++++++
>>   Documentation/hwmon/index.rst                 |  1 +
>>   MAINTAINERS                                   |  7 ++
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     |  8 +-
>>   drivers/hwmon/pmbus/Kconfig                   |  9 ++
>>   drivers/hwmon/pmbus/Makefile                  |  1 +
>>   drivers/hwmon/pmbus/crps.c                    | 79 +++++++++++++++
>>   drivers/hwmon/pmbus/pmbus_core.c              | 13 ++-
>>   9 files changed, 211 insertions(+), 6 deletions(-)
>>   create mode 100644 Documentation/hwmon/crps.rst
>>   create mode 100644 drivers/hwmon/pmbus/crps.c
>>
>
>

