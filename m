Return-Path: <linux-aspeed+bounces-499-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986ABC02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 14:20:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYlPX0rqVz30WD;
	Fri, 17 Jan 2025 01:20:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737037200;
	cv=none; b=Icz6TlcrTPHE8Lpuik5m/FCqTQvpG2WedUGGeOaa2yr+26Mheo1xl8YQw8aybmxLGIPf/xiNXHolC1l0jegoAxzY1xr6xpvUrR40ZpRKt9K24sbTkRrijF+EWbExp9OHbIjtsnRt89BGUO9sB0hxO4d1UQoIU1fnvJQsVOkWxLn9vS5L9+MTpBPpP0ClQrjz31zlg7pY89gobfwkAZPlHQo+SwUk1lZNYzKgJVWXYoZiCDWuBmHR1G+7CBcRge1SpaoxILN1uqkeBO4yH7cJLxpDik33Jt736sVbPm6Z3l33JGnlTkE0tkHe9O4akPZcOgXnvvxE1wh8CVfJSPlCnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737037200; c=relaxed/relaxed;
	bh=kvuoie2cHvRzOctKC4/04/khecJ1IORzLwb4vivzsfA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=CemA/ZmAVyfIYvagdw3qS7bPWzLa8F3JkfHCw/s+MVjWNTBA9bMVjEKW5gh36PLSO3zVsVi1UlElDnOgSOFaZfJz+La7PJkqZe1e7iBxrlwzQdhWaP7lG8rUsD+V9Raef9fIOb7uYGWsg0NanMr967IrymXgxoQvvvoArEyUOo3djeI0kPvWOLGa5VzS98yfcnJPvSsHJ48reIskD93RqA418GKMNvp1706EdTOBHb8zWh8YrYdNmsALg9V+MSwBSuvq2zw9rPZPgj6gmZYHTKDIXbvyXIB4aGtQzHs7Lj8OioOUIb6JDknXvbs/FW6tG1cM73TQyTrUDsfbrcplPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ic/Y8giY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ic/Y8giY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYlPW0zn0z30Vy
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 01:19:58 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDMYWJ004831;
	Thu, 16 Jan 2025 14:19:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kvuoie2cHvRzOctKC4/04/khecJ1IO
	RzLwb4vivzsfA=; b=Ic/Y8giYDGPdQ/mpE5C+CPFzlXRMHphqJoD40Mh0Rzk0Yn
	ygvMjY3Z10JUbo+GMZ6CZuWeIMlyua2bM/Zm8x3/i34cFDo4TPFeLT6MmRgXMnA9
	AuPN7x30jHtbJSgqENy+s8PIv8L0j48EKG8g/a9r+wEUoYkUbtZNXzVfmOcRDDAd
	QyyIT/1rfcqwGaT4iQd6wcf3jXmcQhRiCziixvkdWI7Rl9rHZtMPN1hn9JKrRqn8
	RioPYZ3mY2+AqEr8HxPMdpYf8uLUriBw8yjTlhInnthZOGUQ7hJ9PhXcpYPBB1e6
	25SexvA5Lr0DlO3WYk2U5iHcwt5KvsWrhXMkxs3Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhatus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 14:19:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GE8L4r015341;
	Thu, 16 Jan 2025 14:19:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446tkhatuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 14:19:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GE2pte016994;
	Thu, 16 Jan 2025 14:19:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fke3bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 14:19:30 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GEJUGM27132612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 14:19:30 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C0158056;
	Thu, 16 Jan 2025 14:19:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C98D58055;
	Thu, 16 Jan 2025 14:19:26 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 14:19:25 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------5PD0oWgh2UwHJR8M6w04d9SI"
Message-ID: <10c06fec-b721-4a7f-b105-c3c4c8358a47@linux.ibm.com>
Date: Thu, 16 Jan 2025 08:19:25 -0600
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
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, minyard@acm.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
 <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>
 <oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iRHdmQjKkSr7h4OshupNvXQ6gsirl5r9
X-Proofpoint-ORIG-GUID: FpwEucBS_i92wmwtCKu3Xm7a2H2vxfyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 mlxlogscore=621 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160106

This is a multi-part message in MIME format.
--------------5PD0oWgh2UwHJR8M6w04d9SI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 1/16/25 04:38, Krzysztof Kozlowski wrote:
> On Wed, Jan 15, 2025 at 03:53:38PM -0600, Ninad Palsule wrote:
>>>>> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
>>>> Choose one - suffix or prefix. More popular is suffix.
>>> I was about to say that, but this matches what gpio-hog.yaml defines.
>>> Why we did both, I don't remember. We could probably eliminate
>>> 'hog-[0-9]+' as that doesn't appear to be used much.
>>>
>>> Long term, I want to make all gpio controllers reference a gpio
>>> controller schema and put the hog stuff there. Then we have the node
>>> names defined in 1 place.
>> Which one of the following are you suggesting?
>>
>> "^(.+-hog(-[0-9]+)?)$"
> This. The second part of pattern.
>
> I'll send a patch for dtschema to drop the prefix version.

Thanks. Also thanks for the other patch. It helped a lot.

Regards,

Ninad

>
> Best regards,
> Krzysztof
>
>
--------------5PD0oWgh2UwHJR8M6w04d9SI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi  <span style="white-space: pre-wrap">Krzysztof,</span></p>
    <div class="moz-cite-prefix">On 1/16/25 04:38, Krzysztof Kozlowski
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb">
      <pre wrap="" class="moz-quote-pre">On Wed, Jan 15, 2025 at 03:53:38PM -0600, Ninad Palsule wrote:
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <blockquote type="cite">
              <pre wrap="" class="moz-quote-pre">+  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
</pre>
            </blockquote>
            <pre wrap="" class="moz-quote-pre">Choose one - suffix or prefix. More popular is suffix.
</pre>
          </blockquote>
          <pre wrap="" class="moz-quote-pre">I was about to say that, but this matches what gpio-hog.yaml defines.
Why we did both, I don't remember. We could probably eliminate
'hog-[0-9]+' as that doesn't appear to be used much.

Long term, I want to make all gpio controllers reference a gpio
controller schema and put the hog stuff there. Then we have the node
names defined in 1 place.
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Which one of the following are you suggesting?

"^(.+-hog(-[0-9]+)?)$"
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This. The second part of pattern.

I'll send a patch for dtschema to drop the prefix version.</pre>
    </blockquote>
    <p>Thanks. Also thanks for the other patch. It helped a lot.</p>
    <p>Regards,</p>
    <p>Ninad<br>
    </p>
    <blockquote type="cite"
cite="mid:oezohwamtm47adreexlgan6t76cdhpjitog52yjek3bkr44yks@oojstup2uqkb">
      <pre wrap="" class="moz-quote-pre">

Best regards,
Krzysztof


</pre>
    </blockquote>
  </body>
</html>

--------------5PD0oWgh2UwHJR8M6w04d9SI--


