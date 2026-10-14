Return-Path: <linux-aspeed+bounces-5200-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEFFCC6B38
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X7t0xYQz3bwJ;
	Fri, 16 Oct 2026 15:31:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791995782;
	cv=none; b=kkOLS3oYHwUjvKgjZmPBxgJYsf4G3FjpaH/t1EjWbEIYKae+TJw6cvA3nX/RIDMPg+W/mmNnDzrm3cmMUXjm/nQYWvaRMQKiD5rKADcZwWpWsq803e8IDi+BYHL3EV1DCMkIwR8F3nhUELurCljW7Mn/j35FuSTrR6d94pU6+HKDyvLgm8jxwDFFDfH1qf+2SRYuJcVOXDwrVXdXARNJkeJOpr18cuR4Y1GBvS0x1GLxR6Vg23TBSX5zHvnSmUQiYB3t7jXmEmLOimrdYMooNn5qmmT/2bhRoXR1gnpyPzGfK+Nc6CoWvYi6kfawZQ1r+WvNLV4MEBwE0GvwScMV4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791995782; c=relaxed/relaxed;
	bh=qZE4atZVuUnxe4gh8yTrME7HVReQ6qljuMq3IYiqA/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuQafkBx9/VFJoSvmXXasFokpMLQrRdut7ev/0hZsAe69Gyi/8eagNCNmFdQuwous2MszPxvDGvDsL+fgtiKlKjIFM70XLKG8pRv8/iaTSAbj7l1A1P024a9rsj4xUB+xeS15TBb0h1JT9oEee3UR9kjXUKEUTVfnF1AsQJSQt5T+qBvCxxtUVQ6yWdPMdFVUl4EO85daLoJZgd3BhV0fk34twr1dgnTw02WsQ9M7WMqXhBKv2KCvHImOA3EHw2bmW4VeNJO4XThSkoNzstjRPCwlXW77slI4vlSQUDCg9fP/j0yqo4PNgvLiS7rXlx6GrzpLyetvroKIgl7G116Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NTMjNEvY; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C3RD8ztM; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NTMjNEvY;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C3RD8ztM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=konrad.dybcio@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4cKK1K3yz2yDm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Oct 2026 03:36:20 +1100 (AEDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbRvX3813089
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 16:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qZE4atZVuUnxe4gh8yTrME7HVReQ6qljuMq3IYiqA/Q=; b=NTMjNEvYqdTCrKll
	f6XgOd60FLUu0XdMAj4D7IwL++ZnvVk0xw3E9JzHsXJ5cLwEOOQq3ip4lcEj3Qsz
	FQjLfPpM9zxfgv3zGMEYeSPgpIfndEwxOrtxSneycTU/s2FeHk06HmPPMYTlx3Ma
	VorPWR5d7vtllaxOSeBTeEsBifuxva5XOLjtdg/zpLiQ7g7soCORo+i8zsJMNwgG
	YxXHxU7XBSeSJsREwCIvF6zEhvS6aRW9IHeaoxldVxCCf5PaiaNXBVxwvpYdbwWi
	wKzzxsCyVjL0f6aT2QyitUg1BKR992QBb+EQK4OC9L9HmcVsqp7eFdoRNUTkUea2
	QRN/qA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u2jc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 16:36:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92eebb130dcso77878685a.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 09:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791995776; x=1792600576; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZE4atZVuUnxe4gh8yTrME7HVReQ6qljuMq3IYiqA/Q=;
        b=C3RD8ztMcP0b11XqaEOHoe2ic1G8M+9dlJkE2c7V082BBJFdsNpMwFOM/+drIU6Cxo
         Qxjcq2FrrZdjVeKCjdfxSjUucEuo3sh+uE3AbcVRFE3f5DDDCFJVtYWbBVfrpO6ketSM
         aePqrUmmiiTpSZc5vHOD8YOJUG4nuazyuswhqEQAKUn1gUbYWcsYJnoFiNn9hpNBb/HG
         zwuyUMmCDyr9myo5ZlVFYUdcPIjbeeq32N3UI8EDmk1q9IHHae6vrwos5LHxiT4ltUN5
         aZIaSO09fWtkaF+8E5dQUyteGKzRaUfKe4gB50/Cd0zeVsASkLdOztEh8LJyr2jsk9qB
         8shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995776; x=1792600576;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZE4atZVuUnxe4gh8yTrME7HVReQ6qljuMq3IYiqA/Q=;
        b=wqB8opCO93P6d4QyTY8ZlmDO0kH44uy0ZPbiVFCv66oxllXpSleFz9vwjIbtWY322g
         XElpwh2ARumvzHKTOShXb5sqr+VsFKtFgR/f5xuroU0mPMwodrpymtvegRdRCOiwuWpu
         so+utHT/P+xDITCWVaM8XQBW4y4r8/i9GILLEJCJ50qKnGZjarVRc6WXbgQLtVYRFFUL
         aETKT/RaI1UDbWRKTWoCRzMEl0jVDT1sdIWrvIyMNeBljqU8m3wStzmUJJ6Ai4plTB+L
         aHkEAR4KrpMhD0EO+RcjQ9xnY4C4aiXYbPbNvG5LilgXx5R/ZHa+tSZmIZvcKSosfiny
         zN7g==
X-Forwarded-Encrypted: i=1; AKwUvBxAI//cNSY9B39BaLXsUq+smTj7U8Brm1Xu55LuICrEQXgN/JJlmnhvfMSanYGn693FADnhWNOKsKgNevo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKOEhnOQuDSZbi768eqh+KsgU33hfFZ6yhLAlhJZLf38TTmS2dS
	8P9xPKCBeIF5d4fjODa9ndVz60J1tRpXcSl1xRZ0mAPypfinrjeCoDmluVPODG15GRn4rSweoLo
	yPSPadctSdOiIXVDTEOTw5uJBj9GQUMs1Z4aZmFMsxfTHKW/buxS9dQk4vlLdAqipkwvf
X-Gm-Gg: AYBFou22SGJK2ONzneAXlJ9X0V3u4+KV23/sowrpsOtVajUkuaI/0g80j98CXb3SA1M
	EetS3uMsFYt4c05b9TaIC8M50urJEgojTqjpZnzUjC8tUQGA+u91t5IoPJ4ni67YGkpjPBDLXuG
	W49WGnDmPbrgfMRRkoo4CukOYb6X7o4aXSqWPzMbeTIkBp+JDVFa/ts2cUMrDFUSzME3QSjV9TA
	vzTp3BfZcjEc9l9trBOzQHSkms7nwgIyO0tFl3eSf36q/9ike+s/7eel2fCePjTeFSpfOJY4dOF
	mEE/v7OvdkYo2hNSUDXPPIZmhC0dsK0IteH2JhtWYizsalJ3McdzEugiCWg7tCW34brXR6icgcy
	7OC7eT49M+kw0z5KsbY8S+g==
X-Received: by 2002:a05:620a:3186:b0:939:8bc:8826 with SMTP id af79cd13be357-93ebd10c0e2mr3128577085a.2.1791995776351;
        Wed, 14 Oct 2026 09:36:16 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:939:8bc:8826 with SMTP id af79cd13be357-93ebd10c0e2mr3128568885a.2.1791995775873;
        Wed, 14 Oct 2026 09:36:15 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20386327csm1289977a12.18.2026.10.14.09.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 09:36:14 -0700 (PDT)
Message-ID: <b4c0761b-34f2-42ad-97e7-ab34ae776281@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 18:36:06 +0200
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
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port
 numbering
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
        Neal Gompa <neal@gompa.dev>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai
 <billy_tsai@aspeedtech.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Peter Griffin
 <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, Yixun Lan <dlan@kernel.org>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        Minda Chen <minda.chen@starfivetech.com>,
        Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Wei Yang <yangwei1@eswincomputing.com>,
        Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
        Hang Cao <caohang@eswincomputing.com>, Li Jun <jun.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Roy Luo <royluo@google.com>,
        Yang Xiwen <forbidden405@foxmail.com>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Robert Marko <robert.marko@sartura.hr>, Xu Yang <xu.yang_2@nxp.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Ze Huang <huang.ze@linux.dev>, Aswath Govindraju <a-govindraju@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-aspeed@lists.ozlabs.org,
        imx@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
References: <20261014082037.1774672-1-wenst@chromium.org>
 <20261014082037.1774672-3-wenst@chromium.org>
 <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org>
 <CAGXv+5G1kgyumbj7wGf6rPFbg3spSO0zYmEkn-hZT4qUdJbytA@mail.gmail.com>
 <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <03375a31-0ac6-47a4-b0dc-6327080e1622@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NiBTYWx0ZWRfX8VO3ETchezhh
 DlLTa5bCJOMMzaqDqMuglkHDmQe7A+ZFc6mO8dJ1KLqmiPTwyt6GmYaDfbZKHCdK5QcLhNI+rfQ
 r6dQorHWmPCpdAlggzTub0gbWelRqq0=
X-Proofpoint-GUID: oe-lHCDqTaij-aDuzJEQbJOlKSMnDvRy
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acfaf81 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=auHUQpDKApYGa_LtnhgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NiBTYWx0ZWRfXysxJO5lzIdRR
 I6Cf1gZaB/eu5Jjww3E5FPcKUPbEYH9JsAfBgRa6ZvxtykN+DaOZkI4zuFOphjJGJ79BNHCDtON
 ovMrboJf4OQxEJZiUzNtKnQCGQI2mc743q7cBBq0toiL4rFskVTrvS5r3qLcCLRscM+gmylyTNu
 cILQUjPwvMrkPXNqX9uyweXAUKA2qQ66uMj51zTh19PIO2RXq4g9K3zAUvMoeqXDaxn9Wb78IZv
 L5Hu2cyF2tE3S74LL9vX7YkiwTMjKDDSDhqpUXbnxEnAjws3VT0G3WbGtxXwS2KaLIA6epuVBsm
 lJPeZxm5ATOLQRoJ6kgm0uX2HOF57S/fJ2VR/ozctVxBD/HNsl4co70YAwLZ+yIb3uvB5Koo8RK
 leVZZxZOz9cDs6V4NzEzccu/CT0tX7VIhzUoXr1ct9tdEwXQjShdMf41ZjS4xlsvAxB/6IA6B8B
 bziWSSgRSQRD56kxCAA==
X-Proofpoint-ORIG-GUID: oe-lHCDqTaij-aDuzJEQbJOlKSMnDvRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140066

On 10/14/26 11:44 AM, Neil Armstrong wrote:
> On 10/14/26 11:29, Chen-Yu Tsai wrote:
>> On Wed, Oct 14, 2026 at 5:28 PM Neil Armstrong
>> <neil.armstrong@linaro.org> wrote:
>>>
>>> On 10/14/26 10:20, Chen-Yu Tsai wrote:
>>>> The DWC3 controller can operate in host mode. It does so with a XHCI
>>>> compliant host controller. The XHCI has two downstream ports, one for
>>>> HS and one for SS. USB downstream ports start from 1, not 0.

[...]


>> IMHO having consistent numbering across controller types would be
>> better. This avoids making the USB core and hub code deal with more
>> exceptions, and also easier to understand and write device trees.
> 
> I was in the impression the port number not necessarily reflects
> an actual physical numbering, and can be a logical number we would
> then map in the kernel.
> 
> I don't see any issue here having base 0 for the bindings and then
> converting it to base 1 for the XHCI port numbering.

I thought base1 comes from the USB spec and not just XHCI?

Konrad

