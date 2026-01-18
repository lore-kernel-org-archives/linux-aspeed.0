Return-Path: <linux-aspeed+bounces-3380-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAC8CA5FE1
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:21:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2W6wdzz308l;
	Mon, 19 Jan 2026 10:21:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759823;
	cv=none; b=Yi5+694x6OE0iTWHIDZ7AiJtXuR873XEQDzi0AOKSspZo5XEhFlVHRslyH2JhlZKa+C1iLN1EZZ+6olpA/hwSPv8GPe6jveTepgSrsKbC5jkjRWQMYGgVjgSzjepnupG/aut6WMzsJfD/uBH4aV1jW43CGNuOndO3KQoYD0bwanuJ8GFZobYUaDgCqyj+6cSf3OFPIJ/oUJSeD56jWJwjByYfbNHSlb6Lp/Pc0jmoP9hI9IEOxxFhblY2GCSwD0R0bsRSu6rp+h/m8CeUWg+i87JsRlk86y5Y12jXhfAYUnVtbX6QhIaktmb64FdJ818ouxpkokKEGYYPAXi33t4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759823; c=relaxed/relaxed;
	bh=bq3v2rgJLKiDEOsLmXv7bz0bBd5gBl7Lr8FAESkXElU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0ivGohcf0zf339bDK3UJ+HJN9WDk0U4olCFXbnAOp1bBdLpIhBrC8kP4QvoObCWyuaSvASNq3ezEajzsyqI8GrW0Mp3jaiL9ylr/dnOPvBCFx4p4r/NIR5+lRurN9d99gmBKekwbHSZhqiRdgDaKSQR35qo/uEEQzuE1u8k7+lLLeJbBQQVWLcD45GrgiC0RWDO+cgHI6USZlOpsw5Ode4vYyptzOxVDZwmrDAjozk3owM5gSZ1kqdooI+il6KNs4l7Mhi/OlXiFXkDGXrxt11cL3TJBt5pJClpMPw8VBfYfvOUznQ1QuLLx3M1LHJLZQ6E3aDGXWL6pfDzlbAORQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pgxM7ktr; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tl4Zj1TA; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pgxM7ktr;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tl4Zj1TA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM7z0zylz30Lw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:22 +1100 (AEDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60ICrRao1947867
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bq3v2rgJLKiDEOsLmXv7bz0bBd5gBl7Lr8FAESkXElU=; b=pgxM7ktrM3C6JNHs
	m+dptkkX0Qv+/1wvRYYLqNk06hFxp42qnRNeX85OydKUK3DfNxmAU/+bhQnSiBE9
	5jFqrFFliVJbtloeqx2ulbLwmsj6LGPdxK8mJ+AOtKFLJ7/FTvUM3lulmSMjMd7z
	jWAXVmGvZ0nJaOhf9+EEzpdpwW0K7ncgLn6+kabCTPUEQ0HRjC4remHm5WAf3orp
	HTpFcUGejLERS01PkijD3DH0btzRlLQ3/O0KkA2D5XV3RZav6SLqyQ/JX39LEy2v
	IApUg/r+kFOm+p4BLIsQHdC+oVN2T7Q62++87p+3q1J62nfSHmj2FUGeDuinLNoy
	mEignw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br20x2vg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c52fd4cca2so937724985a.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759820; x=1769364620; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq3v2rgJLKiDEOsLmXv7bz0bBd5gBl7Lr8FAESkXElU=;
        b=Tl4Zj1TAXD3gv4SXtHogW5vGB0xw7ALURJqTGWYJNuubZythkKdtsqGYN9eq/xoaWN
         aCQjzgcdNPQGztEBcIJVEVJ6esWTlZJ7ngkFXJlmettLhrPzcc+daTUMOxVDBqc2tPix
         +HNnJtVrqd9q0hQbXJNKDAuPHZ/lJMafO4fbi/Ofa6KgVLCsvVgH/q7wAA3SN2juGAs/
         8XJav6XvpPwe9lAWFHws9nzJnEsAPqHWYXwrukz7NGPkkFbpJZIYJN5DcLFdCX6Kgg0Z
         uFeDm+CHSSTtzlZa2CTQIw36D+h3Iua1xVe2YxSb3kk4+EJuiZr8MRrOMj5WD3/mKqp8
         JjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759820; x=1769364620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bq3v2rgJLKiDEOsLmXv7bz0bBd5gBl7Lr8FAESkXElU=;
        b=I9Ts9pGlqqyrbeU8UbOKrYm0wMPxRJQ5N3b/K7qM7ccxb/zmwsvaTH4tORROvQjuK/
         4m/mA0kqRXNTMQpX6VhfP2EBqPqMBXEwNcBI0CnWQ6+mSVIYF6GAhoReTVQ4b9mS4QeM
         uOj7BXAXWKSfF2TgdeV0DL3pUF9KAyc10fR/ffsbO29KLxB5JxsK5B4SoX5NMNgvJ8by
         nWP8d/aholsbJptizfX7uc+yZFXVUA249HDFOcVT7wb0L6J9KXHxAwaE8jLrdgYhHOuG
         OWxw/U/2rQn9fEuks4/M4LqhoVmu6wiKUFJzoejPJ2edFPNadACc0Y7KyXcjhM77ds/D
         eKgg==
X-Gm-Message-State: AOJu0YwzNDjZKz1+2CjsCzKzUZ4ex8l+DZCe+zwL9c6Ho3Ntc0H4Ck1I
	EQEJL6G7bawSUWmSYTeK+OGbRfbwLEMH64ECmvU8EjcS5O412CCvVW2wb7KcGlQFTZ9UOlyduqJ
	e8yXpAlcvDIJzsTte7ZjOjNZzVRKcHO0CMGxyhu34ASKX4MbYn8Y6pj+w6rj6P/G+ouL5
X-Gm-Gg: AY/fxX4pTDb6aMIjEVt/izewwDMAkZ3LQhgtEnLKjn10alLBkhVPm/yQS93VtsDXuod
	CKw8BW+0Ul2C/8sqklY8yW/XD+fMypFosFeFpAijHb+BuLAbyEnhWt6DrSklEPoVGoVv5TeFcoZ
	m20Ejh+D6hnZN0dmR8PdWRDiZS1/qOdTkthOM/jrv2VM0Clb1yjSAn+FIjBsj0rpBXHbh/pL+Y0
	zAmD28QW7x4hPA0RF8JBpGZ/2lz12J5yZRcju+PZqf+cuHU2MupcJsqe/Z5PbGeRrHI4CYuDpjW
	/K+reffdvARlh7zmqIxhcr4oJtpnoKzQ2MQstA8IdoaqgI9pXRhx6DLc47jzKKTNbQM/sgIsQpE
	f7Y23b14PUW+f3rXFC+fMqtlo1zFV/osRkw==
X-Received: by 2002:a05:620a:404d:b0:892:ca0f:fc21 with SMTP id af79cd13be357-8c6a671c788mr1272747285a.40.1768759820195;
        Sun, 18 Jan 2026 10:10:20 -0800 (PST)
X-Received: by 2002:a05:620a:404d:b0:892:ca0f:fc21 with SMTP id af79cd13be357-8c6a671c788mr1272743485a.40.1768759819810;
        Sun, 18 Jan 2026 10:10:19 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:31 +0100
Subject: [PATCH v2 08/11] pinctrl: tegra-xusb: Return void in padctl
 enable/disable functions
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-pinctrl-cleanup-guard-v2-8-bd36f681bdc0@oss.qualcomm.com>
References: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
In-Reply-To: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Hal Feng <hal.feng@starfivetech.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Inochi Amaoto <inochiama@gmail.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zwqMNlVzyh5eJuxel4QxILb1w1jSHcI3ic8DyOkYYFI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSH023tp+pR8RcdVkgtrXrXPyyvJCiTJRQMKg
 Lvm/TsQPiKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h9AAKCRDBN2bmhouD
 1wwNEACGkGa4R5iPxfciaNNGa26cpFVFOKNoQQ/zlFKjd9KdLdP3tK0fWadkQ6Hzg8vIuOQ0s/N
 v7S9aLNuDw74JQ3Y+27cgzgg2n/5allaBhi7p504JFNtRp9VuczJS9/aQzkHBhMBYb4qHa0hbMF
 5B40sNT0sLeOazx6g5oH7IJuwLknyQHZ5fbOnNm3S+Rhbjt4X0zszXGk6S5rQ6TaJx8wStEz2hJ
 +lC51VjrnH7jRwQZzX+zzilyHJ/l+HI120tg6qO3suf4O0SY/DtDfqx147BUPRdV/wmxLJ57ggf
 0TgH/14e1z7TwcuN6zs0miiAII0m2HYe/etu+gBd8fiBtv+uEcW1fdvtFo6xpRvM0cB+ToJ3epW
 J+WAhktebIvSeAt0KWbj0CP31V40a5j9h7uHmWaU7Hev8XkKhQb4BD1OrE9+7qS2Y9ZWqEa/b5O
 IHPpVLfe7pkjnOiOiy8BEgRkXThCYu6o3CyTClOaQRKzaR+YtzAPb+KL5GNuyB0Sj6wmRyqlRj0
 1cOaOus9EEY6i/l6k7smRdmdWfEuQRoG9OOvnXlrwxjA+kZXKGddz4ythESHN77jK5FCbFlL9gl
 yc4UG9zGjHjhRMHycAqi6bFpO7IHu1HO61URwtcZ3WxZe89GryobQ4tMqNi6WqrOhlLfDy6NcCX
 iSdKZI6W2hyvuow==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfX/lIyeKygXyKV
 CMfdHXR1mZJRdIKDXE7PSyeJicIHGsA5QoM/3sONDbcyWEZUT2Ri9n80Wt4F/3jZoIdRjzvRExZ
 ZV2FrVuuAiDTSK04mTFH+xB2Uz8Lzno2tIE2ieti4i2UzTn3KhLhWS/Dj/rTgO8/roizulgG1Vx
 ZH83Vw3YA2Ik0sEnUt7FR1uO9zo8apIpDUgJiWGX8VAWUaR5N8S+gxeJxWO04D7YO6mmXIQeZO7
 F/WDoz5cDELQ6Td8eAQvO89UGMwRIArzjMpoVx8k5bUQ0x0/+FbjesqoN9K+UBCDizh1PwmhCT8
 KHnx4g7xuB7LFZFq2fndartF4qfmAP1dRUtKqWFoUpYZ+OM3rvHkijw0KSJXqmchZl98AAU0GPh
 l5dUHj8m4wGw6mD9TtJ670o7YV1Q4Q2G2bV72AIqMZ7LmlBEi3xmu8DYpRfgekq+0FWw9rjhjqS
 km6SQTpYWEy13E4dIbA==
X-Proofpoint-ORIG-GUID: dr1EmDjN0KAc2BGrPNCsn6DISQ-LP6ub
X-Proofpoint-GUID: dr1EmDjN0KAc2BGrPNCsn6DISQ-LP6ub
X-Authority-Analysis: v=2.4 cv=abRsXBot c=1 sm=1 tr=0 ts=696d220c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ikd4Dj_1AAAA:8 a=EUspDBNiAAAA:8
 a=Ed5BEzkqmhObfCaRRI0A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180160

Make the padctl functions a bit simpler by returning void instead of
always '0'.  The callers - phy init/exit - still need to return 0, but
these are smaller function without if/branching.

Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
index 49c5edeba87f..34a373f7e04d 100644
--- a/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
+++ b/drivers/pinctrl/tegra/pinctrl-tegra-xusb.c
@@ -474,7 +474,7 @@ static const struct pinconf_ops tegra_xusb_padctl_pinconf_ops = {
 #endif
 };
 
-static int tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
+static void tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
 {
 	u32 value;
 
@@ -501,10 +501,9 @@ static int tegra_xusb_padctl_enable(struct tegra_xusb_padctl *padctl)
 
 out:
 	mutex_unlock(&padctl->lock);
-	return 0;
 }
 
-static int tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
+static void tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
 {
 	u32 value;
 
@@ -534,21 +533,24 @@ static int tegra_xusb_padctl_disable(struct tegra_xusb_padctl *padctl)
 
 out:
 	mutex_unlock(&padctl->lock);
-	return 0;
 }
 
 static int tegra_xusb_phy_init(struct phy *phy)
 {
 	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
 
-	return tegra_xusb_padctl_enable(padctl);
+	tegra_xusb_padctl_enable(padctl);
+
+	return 0;
 }
 
 static int tegra_xusb_phy_exit(struct phy *phy)
 {
 	struct tegra_xusb_padctl *padctl = phy_get_drvdata(phy);
 
-	return tegra_xusb_padctl_disable(padctl);
+	tegra_xusb_padctl_disable(padctl);
+
+	return 0;
 }
 
 static int pcie_phy_power_on(struct phy *phy)

-- 
2.51.0


