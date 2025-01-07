Return-Path: <linux-aspeed+bounces-324-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8866DE77197
	for <linux-aspeed@archiver.kernel.org>; Tue,  7 Jan 2025 14:28:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSD1F1Kcsz3bTN;
	Wed,  8 Jan 2025 01:28:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736260097;
	cv=none; b=B/qk64rg+HGx1LrXVX6hyARQi6y2+3MQqw+haWoWkphIgipOYbGcOmqoA/aDvg18WHiPbXUJGZqFdeB3nThmzDAJkqL4fTm9N9iXvXT0u8JrFAhV1GXp14yN9aQUCBIfj+d79UQg+dHkOwqTWpQpnXjSwCONtTUv6RX+WsNAxJcMAJToPRDtqb11vR9TjkZzb5duCH4dYLqHsVVRsBpybyeoaB3OlsRAeERxgXpO+2CE0ylgB88E0b9jSk4CfPX7RdqqgnF5CTTwAvuPDriIFAc7r/TJ5gCeYD9r66mrtdDKGAw3+EeJcmcYW7UQwlvULEhSMLXJgWyPah+YzU91Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736260097; c=relaxed/relaxed;
	bh=DtsVO4bX6bqkrt6Rcem6MpHxL7CRtP1LT4AwpzBXqvs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=GzGVVOmVm4HE1voCKbft1CJXQbRppEOYA+3jB1P8Sjj0NdK4b7Z48y7A8fg3oiSLwAQBpUvfKKigj1+lmrVaS9mjgbVtyLY/oUj0D7z1LdITUhuW5VGkjQddWpRehFiniCuefRbioeZlDCE5EhzOpka9e+vgXuILkAD7SYIJdjSRrPvgIYmh0P75R/vKgn/wYpyZkQ/LFCyGbhrEkI40Ag19M9fhFOQUASki4K449RTxTqWYJoHDkWL68Fpl5Cjm7l+MRWkokv69PIrDm3EbmPIAJ3E7s+p2I97ookjuKt6Z2kk7++6QtoupVoH3PoApabTYmIruRKM4mp3VQtqQ6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XPuJ4DpJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XPuJ4DpJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ninad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSD186zhfz3bTD
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 01:28:12 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507E6wCH016317;
	Tue, 7 Jan 2025 14:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DtsVO4bX6bqkrt6Rcem6MpHxL7CRtP
	1LT4AwpzBXqvs=; b=XPuJ4DpJVbPlDXwslGo+3mzlxWoTQu78FW+MzqyX+uS26t
	pfOthDcF4R+cCqnHhB+KuIINYjwvQ1aafa542sheIw+tAG3wKQG8dS7+bGjd7KQI
	U1RRQMc9XcGAWBlql02dFw2wDp58kGoQlQezTLg28WBpXSM21G4Cq+/r28CYxqLB
	YdKqEnnK/7qPcLHC9VOauD6QbPOMIXJBWsdD+pDEN2N598d5G3sOyiI6LnxpGfGm
	2sNa0R8WqiZkL/EWlQP+6dSYIsPb8SL5beXglKwSlgXclqgV2a8LUQuPIA2s8rIh
	Wuxxj63gRd2FDfAS4rkZ03n2Jj7KdrPReySLO3LQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4415r503fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:27:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507DrCMP027997;
	Tue, 7 Jan 2025 14:27:49 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk2n2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:27:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507ERlHS37159542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 14:27:47 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4D55805C;
	Tue,  7 Jan 2025 14:27:47 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D6AC58051;
	Tue,  7 Jan 2025 14:27:47 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 14:27:47 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------10mIdk2ZoitodkVrhc2nm9Id"
Message-ID: <62a4c8b7-22bb-4a00-8b99-e9a66bc3279a@linux.ibm.com>
Date: Tue, 7 Jan 2025 08:27:46 -0600
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
Subject: Re: [PATCH v1 1/8] ARM: dts: aspeed: system1: Add IPMB device
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, eajames@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: NINAD PALSULE <ninadpalsule@us.ibm.com>
References: <20241213145037.3784931-1-ninad@linux.ibm.com>
 <20241213145037.3784931-2-ninad@linux.ibm.com>
 <45b55b4b-25e4-4e8b-8c95-8c3129e72227@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <45b55b4b-25e4-4e8b-8c95-8c3129e72227@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U3lRSUTcbi0H4GrTJKnAQ2hp-meTvQzO
X-Proofpoint-GUID: U3lRSUTcbi0H4GrTJKnAQ2hp-meTvQzO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501070118

This is a multi-part message in MIME format.
--------------10mIdk2ZoitodkVrhc2nm9Id
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

Thanks for the review. Sorry for the delay as I was on vacation.

On 12/13/24 09:48, Krzysztof Kozlowski wrote:
> On 13/12/2024 15:50, Ninad Palsule wrote:
>> From: NINAD PALSULE<ninadpalsule@us.ibm.com>
>>
>> Add IPMB device sitting behind PCH module
>>
>> Signed-off-by: Ninad Palsule<ninad@linux.ibm.com>
>> ---
>>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index 8f77bc9e860c..51a116d7041a 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -763,6 +763,16 @@ i2c3mux0chn7: i2c@7 {
>>   
>>   &i2c4 {
>>   	status = "okay";
>> +	multi-master;
>> +	bus-frequency = <1000000>;
>> +
>> +	//Set bmc' slave address;
> Is this relevant/useful comment? Why is it even here?
Yes, Removed the comment.
>
>> +	bmc_slave@10 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> Also: use DTS coding style (there are no underscores in node names) and
> use preferred naming scheme (see general kernel coding style / naming).

Changed the name to generic node name.

Regards,

Ninad

>
>
>
> Best regards,
> Krzysztof
--------------10mIdk2ZoitodkVrhc2nm9Id
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hello <span style="white-space: pre-wrap">Krzysztof,</span></p>
    <p><span style="white-space: pre-wrap">Thanks for the review. Sorry for the delay as I was on vacation.
</span></p>
    <div class="moz-cite-prefix">On 12/13/24 09:48, Krzysztof Kozlowski
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:45b55b4b-25e4-4e8b-8c95-8c3129e72227@kernel.org">
      <pre wrap="" class="moz-quote-pre">On 13/12/2024 15:50, Ninad Palsule wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">From: NINAD PALSULE <a class="moz-txt-link-rfc2396E" href="mailto:ninadpalsule@us.ibm.com">&lt;ninadpalsule@us.ibm.com&gt;</a>

Add IPMB device sitting behind PCH module

Signed-off-by: Ninad Palsule <a class="moz-txt-link-rfc2396E" href="mailto:ninad@linux.ibm.com">&lt;ninad@linux.ibm.com&gt;</a>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
index 8f77bc9e860c..51a116d7041a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
@@ -763,6 +763,16 @@ i2c3mux0chn7: i2c@7 {
 
 &amp;i2c4 {
 	status = "okay";
+	multi-master;
+	bus-frequency = &lt;1000000&gt;;
+
+	//Set bmc' slave address;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Is this relevant/useful comment? Why is it even here?</pre>
    </blockquote>
    Yes, Removed the comment.<br>
    <blockquote type="cite"
      cite="mid:45b55b4b-25e4-4e8b-8c95-8c3129e72227@kernel.org">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	bmc_slave@10 {
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
<a class="moz-txt-link-freetext" href="https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation">https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation</a>

Also: use DTS coding style (there are no underscores in node names) and
use preferred naming scheme (see general kernel coding style / naming).</pre>
    </blockquote>
    <p>Changed the name to generic node name.</p>
    <p>Regards,</p>
    <p>Ninad<br>
    </p>
    <blockquote type="cite"
      cite="mid:45b55b4b-25e4-4e8b-8c95-8c3129e72227@kernel.org">
      <pre wrap="" class="moz-quote-pre">



Best regards,
Krzysztof
</pre>
    </blockquote>
  </body>
</html>

--------------10mIdk2ZoitodkVrhc2nm9Id--


