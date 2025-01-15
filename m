Return-Path: <linux-aspeed+bounces-493-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A896DC02180
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jan 2025 21:54:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYKX71S7Dz3bq0;
	Thu, 16 Jan 2025 08:54:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736978055;
	cv=none; b=myURLbhhSv7TM0CfPlomzco0qlkqqxtyFvLOeNv0Imus5oWx78ti0zuXqBzwJmfq/pgUlJ9MnX2sVMTSMK2yuWZkohZY4hW3Cx7cAzCBuvTv/sziw+yoSjWl+eDyflY5asqcd1Rwt41bb9f7GDo/sD+McccvrGFvpPfQpSBIggpwieYZq47xyl3xzV53gNlRll0cgfZoiRKdMZYdvt7MxH6ld9hbqvkn1ivtF9B8rlvoXfKvJDIxx/ywPJw/3AK6DC/MSg6obopptc2Uek5A680TPFGdPkR/49B67J9gT4yfsqdUkVzo9OjEbJCwsyYXQvsCokQvpSg4w5c+a4yw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736978055; c=relaxed/relaxed;
	bh=TzpXaZVhH3eqHenHViKCjdEQGUU6qnZx4yq8XoragwU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OKqpM1qiHmcU7yDadvY0xI6RbCPbRVZSWVLpDiD+yO/luThmGACMswwa2WAPvNTdxHLzqRKYGHihFmqwDW2QCR8K+P+n1Vm3qafNoWagFb1g+U+jaExhC6tFvirvBQoingNYYuDIlx1iv/s2jWmFaSAUPBUAb2QKxWnztu8Z5m37vI+8OYfqRYguOLvZQ9rJJnI/MzhOrN5kl53HijqOzd+L8DelG8PvPigo3F4rVn8QCLgdUHY2rlXAFDIe7x+6n1i0GpvCZ17SeUnbFl2gfCnjrrcfmAszBKT/GEmZUtb+0DFZgmSmqT/8FAyTHFUNNgPc1H0jYH0PhOvI+JGqXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nxj0p9Y9; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nxj0p9Y9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYKX62f4Gz30hQ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jan 2025 08:54:13 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FHX5Tc000836;
	Wed, 15 Jan 2025 21:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TzpXaZVhH3eqHenHViKCjdEQGUU6qn
	Zx4yq8XoragwU=; b=Nxj0p9Y9/7i2/hCO+avoY3MFnfxlL+Ij/EPPF5CL1/EQuq
	GubT5SyeWPLREdWs27s8YdXAB/GsdqPyRSb+Gt91ni81T4MTZJAcK+dX1qxg0v4Y
	Zho/T1hRTBwVxgvT+jEZegUefIAu/3z2fCueB4TB4OOx2UTUMVJTmkA2sedKSU99
	SsIIGnAmHSnL76OAqUI5k2+RaVs0bk7txfQ4ixoYnM0oU0j7rpdpi9AF9CfZEmRB
	wze0+eg42BLjjaIjARaJOBF5Q84BC5h1lQlYhZARHeMdC1qiieN+KUxvaz9ODT8/
	VquVDKmxkSmH5aFyYkUWEnlH6u3OPEw5DRaMpsiA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbvs43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 21:53:45 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50FLriCx027772;
	Wed, 15 Jan 2025 21:53:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4465gbvs41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 21:53:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FJCi0b016498;
	Wed, 15 Jan 2025 21:53:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1t8n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 21:53:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FLrgFs21299906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 21:53:43 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9E9458054;
	Wed, 15 Jan 2025 21:53:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27D645804E;
	Wed, 15 Jan 2025 21:53:40 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jan 2025 21:53:39 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------M63O9CT6nsxzWiO8YePzjvSE"
Message-ID: <a164ab0e-1cdf-427e-bfb7-f5614be5b0fa@linux.ibm.com>
Date: Wed, 15 Jan 2025 15:53:38 -0600
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
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: minyard@acm.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20250114220147.757075-1-ninad@linux.ibm.com>
 <20250114220147.757075-4-ninad@linux.ibm.com>
 <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
 <20250115142457.GA3859772-robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20250115142457.GA3859772-robh@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: N0qq9DarB3vpRhUB6kGjwhL57QFm0RUJ
X-Proofpoint-ORIG-GUID: 59NEuzXQaaEoT921uCHvZsT9sSdxJDdd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_09,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501150154

This is a multi-part message in MIME format.
--------------M63O9CT6nsxzWiO8YePzjvSE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Rob,

Thanks for the review.

On 1/15/25 08:24, Rob Herring wrote:
> On Wed, Jan 15, 2025 at 09:45:50AM +0100, Krzysztof Kozlowski wrote:
>> On Tue, Jan 14, 2025 at 04:01:37PM -0600, Ninad Palsule wrote:
>>> Allow parsing GPIO controller children nodes with GPIO hogs.
>>>
>>> Signed-off-by: Ninad Palsule<ninad@linux.ibm.com>
>>> ---
>>>   .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
>>> index b9afd07a9d24..b9bc4fe4d5a6 100644
>>> --- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
>>> +++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
>>> @@ -46,6 +46,12 @@ properties:
>>>       minimum: 12
>>>       maximum: 232
>>>   
>>> +patternProperties:
>>> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
>> Choose one - suffix or prefix. More popular is suffix.
> I was about to say that, but this matches what gpio-hog.yaml defines.
> Why we did both, I don't remember. We could probably eliminate
> 'hog-[0-9]+' as that doesn't appear to be used much.
>
> Long term, I want to make all gpio controllers reference a gpio
> controller schema and put the hog stuff there. Then we have the node
> names defined in 1 place.

Which one of the following are you suggesting?

"^(.+-hog(-[0-9]+)?)$"
"^(pin-hog(-[0-9]+)?)$" any other? Regards, Ninad

>
> Rob
>
--------------M63O9CT6nsxzWiO8YePzjvSE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello Rob,</p>
    <p>Thanks for the review.<br>
    </p>
    <div class="moz-cite-prefix">On 1/15/25 08:24, Rob Herring wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250115142457.GA3859772-robh@kernel.org">
      <pre wrap="" class="moz-quote-pre">On Wed, Jan 15, 2025 at 09:45:50AM +0100, Krzysztof Kozlowski wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">On Tue, Jan 14, 2025 at 04:01:37PM -0600, Ninad Palsule wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">Allow parsing GPIO controller children nodes with GPIO hogs.

Signed-off-by: Ninad Palsule <a class="moz-txt-link-rfc2396E" href="mailto:ninad@linux.ibm.com">&lt;ninad@linux.ibm.com&gt;</a>
---
 .../devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml       | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
index b9afd07a9d24..b9bc4fe4d5a6 100644
--- a/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/aspeed,ast2400-gpio.yaml
@@ -46,6 +46,12 @@ properties:
     minimum: 12
     maximum: 232
 
+patternProperties:
+  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">
Choose one - suffix or prefix. More popular is suffix.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I was about to say that, but this matches what gpio-hog.yaml defines. 
Why we did both, I don't remember. We could probably eliminate 
'hog-[0-9]+' as that doesn't appear to be used much.

Long term, I want to make all gpio controllers reference a gpio 
controller schema and put the hog stuff there. Then we have the node 
names defined in 1 place.</pre>
    </blockquote>
    <p>Which one of the following are you suggesting?</p>
    <pre wrap="" class="moz-quote-pre">"^(.+-hog(-[0-9]+)?)$"
"^(pin-hog<span style="white-space: pre-wrap">(-[0-9]+)?)$"
any other?
Regards,
Ninad
</span></pre>
    <blockquote type="cite"
      cite="mid:20250115142457.GA3859772-robh@kernel.org">
      <pre wrap="" class="moz-quote-pre">

Rob

</pre>
    </blockquote>
  </body>
</html>

--------------M63O9CT6nsxzWiO8YePzjvSE--


