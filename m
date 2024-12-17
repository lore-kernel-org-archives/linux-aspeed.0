Return-Path: <linux-aspeed+bounces-273-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0854AE7717F
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Dec 2024 17:37:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCPBz3Qjvz30Mn;
	Wed, 18 Dec 2024 04:37:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734457035;
	cv=none; b=V+QRPWwQmFXjaBoJzM/zghJWZ24F8YHqTnuMd6nQrkim/0h+pvUBkMkhb3O53id3YMdiwFGtF0y21kR6B7Eoc2i1hTwbvk2yZg7utDaE4uikxN+B43iEX+O2pdK2WWPlDjFNJ0hNuti0Qr0cTfWq2FDNgtMa3UW2HIueUYZuaXgFiHUTPxklTfE53T8SbWK2ugb+1rC0rqg/jw0edgSwe7yoivn0Lu9IMqWv5AKEWnQX2By2knjIOfFG6Zlw33XepJJiwDEqwKY8Jsj1hQW5i2s7av3qLRBl+PlzMWii5TG6LKlz7PWcRido5I/FhLy/fKO5EguRYidTx0tkIpyBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734457035; c=relaxed/relaxed;
	bh=pJO0g6v98gvESn7JKbTO95058fP43fk5TN6hOObRlfk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=aSRIYNI5Mc8Wt2TiWP3PiWPzcenCewvbx4J9i5WLtbNgirV//LSK5Ko+xOosF+bmvH9AGlE2r+gb9+ELifmAHAGNwzRlUv4Rk6u/7CatwjthduDBaZZKk9cbButvZdORsEZK0oW8HabX+OgA7U0y257nNCoKlNOHVVyIzkXnwY0A2MCJyPfLeCdS8EfLeCDIbofzSRhGRubomuTGr6H6KtK9HkD2gaGqFRachJZr1elU2J1eKul1QJENeOIcwN2Fd6FPhfIh2d2NKYJiGirVtl6CNVAC+GHvJ18nLmE0UeS5gClqwnPuv4BHPMKqviTHcAcvswgch/7jl7vaCV3wBQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pnRR+XXa; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pnRR+XXa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCPBy29nJz30DV
	for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 04:37:14 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHE6KSC020873;
	Tue, 17 Dec 2024 17:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=pJO0g6v98gvESn7JKbTO95058fP43f
	k5TN6hOObRlfk=; b=pnRR+XXa7ggDtT1+wm1nwBXRZvjvPHOgg5xA0oZCyM+Jt0
	z721v67CsmHIHMeRj8itBr6LXqf8tS9PmevW2txILmM6x3Y1xDKwysqu3gSsZbIi
	PUo1gWKlzwBl0wbcCsWJeb3T5G6AmZVlyyMPsJdjMkll+52qJbrDShDv+h23J30F
	T9jrNXfMoYL/tEhkREndp5S32p+yGhXARRB1iNB4yNhQwgQLV0motpON+KNXzFBt
	0aNJlSMI/cT2SKRXBtsWYf6BBl2W4ygXntrqudu7bHABU5BALZ1s8twokQwzB4Qz
	h1LI4IFYUpSSOfU2Na4vbaPIixe2OS5/hLSO/GzQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kas4s3fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:36:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BHHMTG3027530;
	Tue, 17 Dec 2024 17:36:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43kas4s3fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:36:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BHFtTsb005523;
	Tue, 17 Dec 2024 17:36:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbn3vva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Dec 2024 17:36:50 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BHHaoK912780066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Dec 2024 17:36:50 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED9245805C;
	Tue, 17 Dec 2024 17:36:49 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3F1658051;
	Tue, 17 Dec 2024 17:36:44 +0000 (GMT)
Received: from [9.61.165.36] (unknown [9.61.165.36])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Dec 2024 17:36:44 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------B53FnkL9CkYq5UERVvj4WOB9"
Message-ID: <71332e94-4005-4215-9d7f-7e9dd4c2850f@linux.ibm.com>
Date: Tue, 17 Dec 2024 11:36:43 -0600
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
Subject: Re: [PATCH v3 3/4] dt-bindings: hwmon: intel,crps185: Add to trivial
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, eajames@linux.ibm.com, jdelvare@suse.com,
        linux@roeck-us.net, corbet@lwn.net, joel@jms.id.au,
        andrew@codeconstruct.com.au, Delphine_CC_Chiu@Wiwynn.com,
        broonie@kernel.org, peteryin.openbmc@gmail.com,
        noahwang.wang@outlook.com, naresh.solanki@9elements.com,
        lukas@wunner.de, jbrunet@baylibre.com, patrick.rudolph@9elements.com,
        gregkh@linuxfoundation.org, peterz@infradead.org, pbiel7@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-i2c@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20241217022046.113830-1-ninad@linux.ibm.com>
 <20241217022046.113830-4-ninad@linux.ibm.com>
 <21008f97-d0bd-45bf-8e10-9ec2539ed858@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <21008f97-d0bd-45bf-8e10-9ec2539ed858@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: t5ZCVQPd7E7bf55RZ-cojhAL0PehfWEc
X-Proofpoint-GUID: -OexnxIj1ca2J81KPTCj1RFFCwyAYgWQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412170134

This is a multi-part message in MIME format.
--------------B53FnkL9CkYq5UERVvj4WOB9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

Thanks for the review.

On 12/16/24 23:49, Krzysztof Kozlowski wrote:
> On 17/12/2024 03:20, Ninad Palsule wrote:
>> Add INTEL Common Redundant Power Supply Versions crps185 bindings as
>> trivial. It is trivial because only compatibility string is required in
>> the device tree to load this driver.
> That's incorrect reason. You should describe the hardware, e.g. the
> hardware does not have any resources, like clocks or supplies.
>
>
>
> Best regards,
> Krzysztof
>
Updated the commit message as per the suggestion.

Regards,

Ninad

--------------B53FnkL9CkYq5UERVvj4WOB9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello <span style="white-space: pre-wrap">Krzysztof,</span></p>
    <p><span style="white-space: pre-wrap">Thanks for the review.
</span></p>
    <div class="moz-cite-prefix">On 12/16/24 23:49, Krzysztof Kozlowski
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:21008f97-d0bd-45bf-8e10-9ec2539ed858@kernel.org">
      <pre wrap="" class="moz-quote-pre">On 17/12/2024 03:20, Ninad Palsule wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Add INTEL Common Redundant Power Supply Versions crps185 bindings as
trivial. It is trivial because only compatibility string is required in
the device tree to load this driver.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
That's incorrect reason. You should describe the hardware, e.g. the
hardware does not have any resources, like clocks or supplies.



Best regards,
Krzysztof

</pre>
    </blockquote>
    <p>Updated the commit message as per the suggestion.</p>
    <p>Regards,</p>
    <p>Ninad<br>
    </p>
  </body>
</html>

--------------B53FnkL9CkYq5UERVvj4WOB9--


