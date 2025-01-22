Return-Path: <linux-aspeed+bounces-533-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FECBC02181
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jan 2025 16:04:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YdTR01t7Nz2yDS;
	Thu, 23 Jan 2025 03:04:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737561852;
	cv=none; b=O3YxLs/owcUSlKdFuVJAe/3eGgBi1sHvvZCu9/OT92JGLwQP0K1L+d9UFI+M5Om/YitcUeOk8cYJYE9f3i+3xYGc57kwNLs3ZqzeXlCYQrJ7GjZgElGRqBqzJ0CcLom8LHJXU5ZwzPeWIYK2Ida5ogJF33w/TT7NNFm9lJyrtgFpT10N8rt1+ViB4TvE5c/BFhwYzmvzE1E3Txqg+wOlR+eUfFo52QMTbKJx7JfVuv3x8SNPmFmR5Or4sWoOQiIlhyVuY9EiH7bKl8xHvA0/Rou8+rblfusQJ2GV7aUexeaAdtiGZrtv3gqOaPoInbqAzpFcjOd3V81h7SWENzXjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737561852; c=relaxed/relaxed;
	bh=emNQhmJZ7Z2JjtO0Y32AqnVeH+QmdhmkBmXJky0AeRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OUMdxt9cVbzNoL4usWGBAi/532+QKaXZEb530vpx+SV9qbzjPbhBDZXyS2BOfhdnUyK4WjV3UmD3/li1umuLJlW4PjeTuDozaNJEFM1El1vBIT6zAgIqZZ6wCpN+UeledhsAIHi24XdAKJeVSCWBbv3XJ4E+VQC5tgLwJuB8dUSNvY88YffXJv+ayGaFHMT49yeeyAkclstKp29888tEUl0AXy84GGokANX0usJ8PQ2+h/aX/ZKTZA0J6yBw2jvR7nofoSn3HlxpciWZbEETmncjh3KEX0/wPRgqLk2wcxetzqwYTwprWfT8tCbPtwexawYPCHC8xhf/238dEPVvdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Po+DroPK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Po+DroPK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=eajames@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YdTQz1tpvz2xWT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jan 2025 03:04:10 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDStHH002851;
	Wed, 22 Jan 2025 16:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=emNQhm
	JZ7Z2JjtO0Y32AqnVeH+QmdhmkBmXJky0AeRc=; b=Po+DroPKIy7p2yAGzsacy/
	9+BTGd4ojmtGEjWqofWqNbyoGP/aDPGE9xUSRltcKasJfWo3xN7UaWCz5HuxAxw7
	SDSLj2ucSnPsUhRF2ZSv2MbTAxVpiZaRGJ4nJWS7LCK+YksFNVQgKD2nquUcU6mo
	gQkCUd8PrfsxP3X+dkXZXEYVV3tLyNNT+4bdhPa2STR7bn6cJUUp1CxUNn4mA/R5
	1ccMYv72HqNcIYyct2HmRFEBcABsdFbsUlMx1uh9IrnxrFphxebZm53VHLuFjq1e
	vJAT/BA/tBt7QZX3JZnAUwpadM4fLuMZlO31lBHssCMzatCWypewPnE5fqe7chZw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aqgykffb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:03:49 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50MG0aTa032553;
	Wed, 22 Jan 2025 16:03:48 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44aqgykff9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:03:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MDkxai019261;
	Wed, 22 Jan 2025 16:03:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmshbdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 16:03:47 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MG3lY513894332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 16:03:47 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E685658054;
	Wed, 22 Jan 2025 16:03:46 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DC2958052;
	Wed, 22 Jan 2025 16:03:46 +0000 (GMT)
Received: from [9.61.66.14] (unknown [9.61.66.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jan 2025 16:03:45 +0000 (GMT)
Message-ID: <4d44da2b-657c-46d3-9e56-92bbc655f46d@linux.ibm.com>
Date: Wed, 22 Jan 2025 10:03:43 -0600
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
Subject: Re: [PATCH v6 04/10] ARM: dts: aspeed: system1: Add IPMB device
To: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, openipmi-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
 <20250116203527.2102742-5-ninad@linux.ibm.com>
Content-Language: en-US
From: Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20250116203527.2102742-5-ninad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9MM7J9VC_-lk4OuohgaJMglYoGtvsthY
X-Proofpoint-ORIG-GUID: 2FJpZuPGP5oAj8zaLR2klah2YAt0O69V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_07,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=856
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220118


On 1/16/25 14:35, Ninad Palsule wrote:
> Add IPMB device sitting behind PCH module


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> index 8f77bc9e860c..0d16987cfc80 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
> @@ -763,6 +763,15 @@ i2c3mux0chn7: i2c@7 {
>   
>   &i2c4 {
>   	status = "okay";
> +	multi-master;
> +	bus-frequency = <1000000>;
> +
> +	ipmb@10 {
> +		compatible = "ipmb-dev";
> +		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +
> +		i2c-protocol;
> +	};
>   };
>   
>   &i2c5 {

