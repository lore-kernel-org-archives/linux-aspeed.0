Return-Path: <linux-aspeed+bounces-504-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B13C02183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Jan 2025 15:09:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YYmW74qqlz30Mn;
	Fri, 17 Jan 2025 02:09:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737040195;
	cv=none; b=O9Aw22wNrEPDQB8/N8bhx2Ym9Zxx/wi7Wj0uNLmMn6FC0HZjo0jTet1pfhrXiA1jyuo8BtaX48fZaPkfsXzwRCnS4HP6x3X9dMFeoW72jZAbcKkFntNWkB00liNt0M2PEvX9jfneJK9vOkKhQ2CTU5oA4T+Au2XoL7ye6PNlbqNOFsvm16tqCplGsZ4X1s0KYI/0rUyBbOTPJ/l2Uo4zOvoW73N7NyYL8LlC/xs4EWB6ecJRAS1YG6vPAKReq1b6ktpyKTqsx2LtVM9UH7mPesuDfjM1eJhyFicxfn+8/7aPPOs2ZsOZn8bo9guzOcXVicNE02C63WCOJLRwF2pryw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737040195; c=relaxed/relaxed;
	bh=dV2Pcid8HsWqw37L8am+YTKtRpX5ZjFhn238QfxByf0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=cZSDpbFz7IO89fVmo1+3nNZMaeHdBYcdTCDVDB/ncCOOUVAHo1/WTeZqeyoTDAbipd5Hsb7MY1fmX2R5MjJGICgVqOLur/h8mK+pNF8WfLrbuXKRpSnandXoslXvEVk1gnQhaANHPASH3dZJs6FgeyZz3iRG1LNRDp60LZiMFBYVx3O5JsXW2AktqhpmI4cZlW3apBsYKCcA7rNESkZi9Gr5/vyNgt1EIWaMgCQxfUFQYM+gXUrusmVvxH7iFRb/4t0n/K30R177Ud+3nhalKYR/Gf0fZsrrV3RUtHh8z7H0Xa/P5ys9smatkdkXvAOCp6HsN3jnEMvC6YSIvO1mjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bF1bkcRC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bF1bkcRC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YYmW65znrz30Ff
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Jan 2025 02:09:54 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GAdR0f022785;
	Thu, 16 Jan 2025 15:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dV2Pcid8HsWqw37L8am+YTKtRpX5Zj
	Fhn238QfxByf0=; b=bF1bkcRCIOduygSPKnqAMX/T6/Oag1g5BH+4zZnMmaAeIR
	PH1Ft4gREadZISM3jED8wQJfyQecfdzE1JycM2Amvn5tg81MYDHhwEzk2Q2N6Yar
	lsc50GYlO7TwYK7sQiagKXufZrSWLJDP9pH1Vnyev0Z+iwfnJQuSWng4KYCb57So
	kQigG9RhvjLFyMt8A+ewde483k7/QfcPMYkfUfRbvDjR7Oh9HimdWTccrvFFBtZ5
	bZ/EtDDRwJ+TMUet5lPDsmllulR6DfKhrQf6cQmYllzLU5b11XUfZ6VsRmFs6Gpn
	lev2G1YK4DxFW3uD/jnZdAzx77sjqqV7Pu4wJBhg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub3sug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:09:24 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50GEjT58015552;
	Thu, 16 Jan 2025 15:09:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446pub3sub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:09:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDcFHH007519;
	Thu, 16 Jan 2025 15:09:23 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443ynecx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:09:22 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GF9MGI17302164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:09:22 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00CF758054;
	Thu, 16 Jan 2025 15:09:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4AB65804E;
	Thu, 16 Jan 2025 15:09:19 +0000 (GMT)
Received: from [9.61.59.21] (unknown [9.61.59.21])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 15:09:19 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------Pfl6iU6VOZYRBnaxcySYJfUt"
Message-ID: <f60f4c2a-568b-46d7-b6cc-5a6daf496515@linux.ibm.com>
Date: Thu, 16 Jan 2025 09:09:19 -0600
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
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
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
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i4ZweR9hZ4k_EadMK1FfdqI5Qt8J3KMj
X-Proofpoint-ORIG-GUID: VN9vOfncTB44TN01PQclARGLtQf_uRKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=696 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160114

This is a multi-part message in MIME format.
--------------Pfl6iU6VOZYRBnaxcySYJfUt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 1/15/25 02:45, Krzysztof Kozlowski wrote:
>>   
>> +patternProperties:
>> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
> Choose one - suffix or prefix. More popular is suffix.

Ok, choosing suffix.

Thanks for the review.

Regards,

Ninad


--------------Pfl6iU6VOZYRBnaxcySYJfUt
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi <span style="white-space: pre-wrap">Krzysztof,</span></p>
    <div class="moz-cite-prefix">On 1/15/25 02:45, Krzysztof Kozlowski
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:mbtwdqpalfr2xkhnjc5c5jcjk4w5brrxmgfeydjj5j2jfze4mj@smyyogplpxss">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
 
+patternProperties:
+  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Choose one - suffix or prefix. More popular is suffix.</pre>
    </blockquote>
    <p>Ok, choosing suffix.</p>
    <p>Thanks for the review.</p>
    <p>Regards,</p>
    <p>Ninad<br>
    </p>
    <br>
  </body>
</html>

--------------Pfl6iU6VOZYRBnaxcySYJfUt--


