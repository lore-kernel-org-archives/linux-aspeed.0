Return-Path: <linux-aspeed+bounces-3914-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A351F433D0
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Apr 2026 00:01:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwypQ1xPRz2yvh;
	Thu, 16 Apr 2026 10:01:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776078744;
	cv=none; b=ipSv8+rQNPHw4/fk05p3hGwKAwwPJ0Mukccho90djzKcqeRILJyhAvFKTzaXh2Ex7UQB8b68o6Mxh2Hd5YXuYCXfVgR9zzcx0X5ye6t9vYgjk4JYCfvjhnprC6NUbQKMf8aBMxZVz7zRR4F48kJ+eIPQJwnN5gb6MYqRlfrQ/l3+/jyfpOhSeCl0qPtIXXmiCPdp4DMjkK4wjAPAT5yw051NoZhg26x0hRf417wc+kU7BDdjymyAfOWNUWAJ/exNAXA2gX1fAegcEFvYQRGi6ioD0eO+3UpNwWc3NlTT+LbgwtG0hve8ftYvg8OJjG4RIf/RrjbpYT5OqIWVwnQqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776078744; c=relaxed/relaxed;
	bh=7Q13pMNKvA0d7OkiErS2v3o7XzXIeya9tsuMotgXsgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U73PN03rZepA6Uz0e4dS34VkCue7Rn8E9JfxOs0ieCSfsxhLGBgB6QBrGwZaUk1IWP9jtNgSb1RQxI6463nIpyVwrkObGxZeDtISR8md3Fm6kEUhwaqraFgseXYWiM8Sf0LBaZYNBr6BsZuRy2jSlHgOHO4YYlM/7Gx58exZcOv2q1PumzSso8xcfEr9oe7iE6C0raXNT5bVzS437yZfVHglrJfHEItf81wl8iVrukrysC5RaBeAq4SVMnUEmmWotc+SnENvaJCw4gbNWSbg2VXJuat5JHVAqzgLY+2kRUdpHcJzHfb2wANrLE4qsjOmhA26euUNdpO//oivWJgTAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FFiUm1o+; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gbWcg/v1; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FFiUm1o+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gbWcg/v1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvPrQ2kG6z2yS9
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 21:12:21 +1000 (AEST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D74ZbJ1716509
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 11:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7Q13pMNKvA0d7OkiErS2v3o7XzXIeya9tsuMotgXsgk=; b=FFiUm1o+fEzL4QEl
	JwwZTE5+MVZjFPn9+vJwWnKoCb2dyUKjp9x6soTdaYvmNKJ59deI2A+Y1KulYgbM
	P7n/ufXltYQT0VTfYmtOy7ZxMyq0btP1bG8S05drPskVF3V1C3a2L3gcQFx8yk0Q
	HUZT8PEMsdb6fkHlllgZ9bGd+wt5NDmc9jZxrCoWoHFgkT4TC3kBrJB/amzVHvlf
	xJ2FOBDN2/cMSM67xRwJ8nG90SFBTzvR1aN/7nmHIB5H9b9oieKwb/H3t087Qe2u
	6WlCpjAvSPZ/K2ib8vHJBi9nW0tQWHIWKHBshd/qaqPhkUgzADDM2GzT4lUwkRfA
	CB37rw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jvy2v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 11:12:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50da31af14cso58417491cf.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 13 Apr 2026 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776078738; x=1776683538; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q13pMNKvA0d7OkiErS2v3o7XzXIeya9tsuMotgXsgk=;
        b=gbWcg/v1H9QOsImNZhLD3n/gSjvITzj5Zhze1RvAwB5+VNM4dQwSJr0ccAijUZqade
         o8KpKYCoE8TcHslAi1zEp4tuAG2DJbogwIGFL8I4GXS1dxq4C5hUuXEc/vwJwnDJacDC
         DBy6hugpr0M6yHQqsOON4vYAhHWZF1Kbs87Ak5SvG1SnLaBvmaTZbwucSXP53f7gt2Tj
         NKXrGaTJEiY0gbWad1zOOHUebi+CPEez80TOQN/r9tfT85R6K3lgxim8Lnw30yq18hV2
         n8RAdiQScns8XwKnQeiG4dpLAnIdskxzXwnYJ0eVthNDjaxeC3L0mj9ymg7PDpA2xs1h
         0mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776078738; x=1776683538;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q13pMNKvA0d7OkiErS2v3o7XzXIeya9tsuMotgXsgk=;
        b=DG0f2Mvv45P/zAe4HmJYjeCWdTAnozsvvGsPbw5fHGIWvj9x3cyiORAu/9rWW79QN/
         SxTFssGnpwb96Mml9Agtq9cZlZ7g9MKb2nxwAxNcWUPZCzJMx58yJ+XwIV7NJp/woDc4
         BQbnJ0R+aN5jlJHLvsYB/S61Q+Y/3MKqnF8gCvVE1809jahYgzUJBzk/D38FbwXI2Mdd
         SeRwvhZzN8L6BG0zjNzaf8ICFuPDI/abNnxMBuTBvzoupcOLs+Mowwh9SXtGP/eA+NpE
         abuM/HmL1om9HR3KU2jyfDnJde/m31dF8BaQyDYel72AJGV1aYG2qokAUxL4FiFP66Ci
         wKRA==
X-Forwarded-Encrypted: i=1; AFNElJ+DCdIeylhluIQK6mxNUEbLcGzObKxSRFiUu8AbtIdtvXOUMyTCwCzJuzVYvOzuV44R4bKIGJLCBCI9ojM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzbbz49Yymwc8O0UXENaTpJdOonWHN6iFHHu4KIs5TLJDHWGNqT
	E4IkTNNv6HGqgr4KvMJBZPELQpqBGI02QRsAbq0I6Rr40iEj0Aoqw/9uyEXiwLG71Nzwk+zw7rV
	hMF3Y7bX9RWFj1EcRRWcrMRgiEYs2Nzxe1IEARAzhjM1e/Fl82knyxiaFBfZrbWg69cAL
X-Gm-Gg: AeBDiet/SUT24MDC+FerFetyFQw83vJ4pDWDAA/vlBSw2elLym8/0zH1IsEtmHJl78Y
	Sjic4ojWe863gvyHj0Kyi/sX4zzU3zB0MRUP8nc5xPLMPE/4I5LmJyIMhF/aYh7SJ+mW0SueFs3
	UR/cB52xcY2scAOylc8POKM2ivDhGT8B1h34vNQ/GMu4NjMNgAaiTl76qwa+9PUa4d8JfnQNNQg
	Gkzn3ryWL8ksN8VjzgUN9Pkjr6pw/aPcBjufkEsWegym2wVfHqqMkfGgrsQvYWiZfkhAbD1VTWS
	98sHmp3oQNHcVm+UbTxJLn30AAvm9CAEaMcgtNgCZJmA029wKdaA4X4Y/wrtv/R6yUvdSNkM9qP
	XSi9kDXIMzNB2ay0bsw5bm/rMZcJyslAYOkdNDO73Ub2VQGx6
X-Received: by 2002:a05:622a:348:b0:509:5dd4:7192 with SMTP id d75a77b69052e-50dd5c2165amr198617121cf.54.1776078737554;
        Mon, 13 Apr 2026 04:12:17 -0700 (PDT)
X-Received: by 2002:a05:622a:348:b0:509:5dd4:7192 with SMTP id d75a77b69052e-50dd5c2165amr198616561cf.54.1776078737121;
        Mon, 13 Apr 2026 04:12:17 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5b56d1asm277853595e9.15.2026.04.13.04.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 04:12:16 -0700 (PDT)
Message-ID: <dec1aa54-5bfd-4372-8c5b-983618d48291@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 13:12:14 +0200
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
Subject: Re: [PATCH 3/4] pinctrl: vt8500: Enable compile testing
To: Sander Vanheule <sander@svanheule.net>, Linus Walleij
 <linusw@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
        linux-realtek-soc@lists.infradead.org,
        James Tai <james.tai@realtek.com>,
        Yu-Chun Lin <eleanor.lin@realtek.com>
References: <20260410-pinctrl-testing-v1-0-6f708c855867@oss.qualcomm.com>
 <20260410-pinctrl-testing-v1-3-6f708c855867@oss.qualcomm.com>
 <a5e993d2b6c8b57d2057909812ce831877762bd6.camel@svanheule.net>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <a5e993d2b6c8b57d2057909812ce831877762bd6.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDExMCBTYWx0ZWRfX5oxQFCdaBs1R
 uoRv+P4WQSRwEQEOX3YOas1LCZTZGSgi8RUouOACg8V7r75kz+Q35HVxvDEN6X3mSVIx9uXCHp9
 /5jMJCI0t2r4zR0by95U2QEjrK7fuCQEidKYHAauiOoQ07OZfztjSAXfjY3BYJExN5HqaZcMlPg
 N5KEEHiBo6U+TZ8idbcpKihKKikescIDJ2FxRiFIvsul0XCHqRBvSKvy/HvwG1cdEEYmhUZqjDR
 ZKO8+YjGqa00GN6WZSftCMmPIbMeFpXpuAgN2q5BdG82diOMXH/o5WEWonnI3uMywH3ivDXOSxs
 CzOPFxCgLi4AvFzzD/u+E52ttK9JwCNBVzRd0vSF84U4u+2XPt91AskoKHNYAq9IRpmSFai573s
 qhrmW0Mmf3Xow8h2Kk/2UOgYxS0Yz8gU6jfsXpQfyh0PEyMelzT9ZXDJoVA4quX74yHWM1Vv4t5
 EDPELlFI69GanjqShKg==
X-Proofpoint-ORIG-GUID: -0st_DrLEizmKhmlCUuQDtpWukAHbXw0
X-Proofpoint-GUID: -0st_DrLEizmKhmlCUuQDtpWukAHbXw0
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69dccf92 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=kD-Xf_iB5HnCcHWKTSQA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130110

On 10/04/2026 23:22, Sander Vanheule wrote:
> Hi Krzysztof,
> 
> On Fri, 2026-04-10 at 15:04 +0200, Krzysztof Kozlowski wrote:
>> Enable compile testing for Realtek pin controller drivers for increased
> 
> Small nit, but this looks like a copy-paste error from the other patch.
> 
> 	Realtek -> VIA/Wondermedia (or vt8500, whatever you prefer)
> 

Yes.

Best regards,
Krzysztof

