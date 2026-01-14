Return-Path: <linux-aspeed+bounces-3318-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77411D3CC86
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:23:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds0xp6w3bz3blr;
	Thu, 15 Jan 2026 09:23:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404635;
	cv=none; b=S7s8bbRFIXCxJ+32QNJkqcgSmoXbKsQuzlVCCHUfwiIb6T5VZKtn6uejmVfFv+gXctN3gf2uKdad4mbQ6OnDTnK1FeT7/9K5BEgrUleXxWWsqI9nKKD2mlnNktu20ohBFUMNppSXla+HnnrV8E374/3P1UoanjtwlFr3kFvlsdqjQbe4P0DDa9r0w6s+PJQ75rcTJYLnHe29mioTzr5J1IfJBCphtuSTEmXuLzW0rCoK1TA7FQhcwpHNJqVerxwJTX9wDv8wfThRILlYZHSE6FcC0t0GgfFRa7xRyXBKfRD0CnW2KA48GRnRzTfnSrXvd/8Q0+7J6SqAbAOCSbn7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404635; c=relaxed/relaxed;
	bh=N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DF0PAYx9HouYGsjkm67tYXC/DwqByvknS21ohANW+PNfYmIIVR3H7lEr00YKi574SPCEyNvKY+nw4JtX7y85y0/dC9JwuoR5A2HbB5FMo8hgeuiPDT1Px1lYdsgQ5Ba8TRv4KFSR3dLDUByOT+69wPOxSyQbI7rKHKBtvTN3FWZtSoM5TVlYtLWKOIo9JuERMmaLBOY5Ou/orcChTVBeZ4lq1bobfxx2LETEF5yBlCkkxK2MiWiZrKSMVDcbHCnWOZOPOtObN7dkxI4lsbDBIxDVE2Qp9wJNIdnNlmQYHDG9Z028CN9TFT47FpyrqJfusRNyhtcrKiRK9hh6e5g2Lg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HcXKAq+n; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IC1zGUC1; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HcXKAq+n;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IC1zGUC1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnR2ZkXz2xNg
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:35 +1100 (AEDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EA52012902892
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=; b=HcXKAq+nTSgWrzSK
	w1a4GoUXM/XuGU5b7mwyhHaftes3dWz2FIYh0ZaE3kTLg6bSA5zLrYkRq0l7d56I
	Zm46EvXyUcb4YHxT4q3XQ2xwvlv169s2XhxgxhrLV9wGHbn/acVHWUrKL9WeiN34
	oxI+nkOmlEgGJ40GzzFOPwIfQ1plkTis7W6XEwSy+BEcDfNNCKZeJK6ntJDy2gJT
	7cNvU/N9ASdtjEEo+ywOMZabQlMvmsZWBwHPkVfHcbdvH7QZIMXscPa1ebEWAwza
	qmm4xfI7i4asmD1X0oDozzuRdnBuTqOGzH+RTAb0dKUgJPvntm6VZtTm/Ycu5NDd
	OjjOJQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp931h2b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bb0ae16a63so1031591285a.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404632; x=1769009432; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=;
        b=IC1zGUC1wUYytdEx92B0Gxa64mlynlOD0rVgq90/ko6XT858LHFi6N9NJZK2R0YlmE
         jWoppdjI4sTor0I2JFPv35jnIHQjhhUSRd9t+eyV+YRrbaTTD4CpgfzNGmZlfOwebxhA
         mhiCnDQVwb7AJ/6sPIdJ2SR1BgJNZTng9ljSmPd6gN4gsT0ZDkPldikyrFxjgkBjJbnY
         D5w1Zp3v6x/G+XLIuvF7onY3qfY+ARqEXVBajYRRbhulLo1r5aXj+n2zQ+Xj6gYOgCBF
         rEf8dxb1f4YPmODeutwWOZLohmPMo5XxdELdNEacqAwqyBpUGwaPPlkM7sSUAnXUK/o8
         iSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404632; x=1769009432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N8rDVtwaqFFOKGAdA8c98jUQvXsuqYrjM/OKm05D9ak=;
        b=QGJu60DL0dKXxx77D8K1cSChpNk7AIVluwv1N1JJCuMy1N/FabCXi4LafiMpOl4QG0
         NOczY9nkvcohigpxiOJq+mSaAkji3k7w4TUVNluAP07AHi9oFN/6LJgARf5wt3U04Nss
         rvAqVAAtc9aQuFc5DeDG2fg1uUht+4WUxKeZw1csSKbZUZIWutgGeg6naiG7hhuaj5tS
         ZK4UrFhZRWZeYyrWT5+0RZnnP+mSzaHF8+sfvF3c1Ce4atTVhtYQQp8XyQ+UBzrk4L7o
         PCgMkX5USWhpND+mw4KDRviyZxA/3g93yg2SuZA9jVkY4tQh8xkOD/Ss++18UFHkVsZ0
         w6xQ==
X-Gm-Message-State: AOJu0Yz32M6/c6bSh74wWdAqF6fWsyuoOkPJPgaVY4VQ3D4orMC9qeoh
	P0TDoJbwem44W2FrjFGMhaJeaFwMy7nWbvBtQJ3YbzLBAw8zzFiblkMo2h9VkgLAlpZiyAVgtMV
	pR4aJrNB6gAOtPes2T4c4ujm1c26tAlOWUSbBOZRrPYuFq8eI8uUVh3b4Uc/6HRk+PHeO
X-Gm-Gg: AY/fxX4BF7hAwMuznPdK41rSV81QUpRcSsrHiqTiLDeQ1c2/muuoCkkEv0x6qThSvBS
	0VgyI6xbxt3B7HLsC6jxAsPaQZSq/AWgKRE04AxwoHF813wC1J7q50x50R5aeDt6IvS74mpu36M
	D2Ou7MicWQZhoOK4AKoHHSnk6jKKJiI8i+V+zIGm9SoDrX81+wL+wqKMgd8IG/l5RCbH7cwJ9ZN
	0ksTg9K9dK4yCr2vZ57X/ufVleDzvf1ljQr4fq5yN/VYAP8BQ7K93pahzON/RUnDfOOSONR/dql
	DynmFcaiuqFtmycdYju0tsWbY5ORTLN4zGowkMbgeRUg1FdzOXz3JohIuCQlpWNM7dqeqb+6CCk
	hWhO9TeCofj57RiQpkVET8bYIRL0+amSGkw==
X-Received: by 2002:a05:620a:46a6:b0:8c5:2ce6:dc9 with SMTP id af79cd13be357-8c52fb4f058mr411707485a.23.1768404632274;
        Wed, 14 Jan 2026 07:30:32 -0800 (PST)
X-Received: by 2002:a05:620a:46a6:b0:8c5:2ce6:dc9 with SMTP id af79cd13be357-8c52fb4f058mr411698485a.23.1768404631550;
        Wed, 14 Jan 2026 07:30:31 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:30 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:07 +0100
Subject: [PATCH 06/11] pinctrl: microchip-sgpio: Simplify locking with
 guard()
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
Message-Id: <20260114-pinctrl-cleanup-guard-v1-6-a14572685cd3@oss.qualcomm.com>
References: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
In-Reply-To: <20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1197;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7TcfQldnwsgDeNj9THUL7ZJpvo8wBH6EB0ftex+EuCs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aFcSlR3KaVGiIyNYG8oZHo4izzrC/c7v2QI
 ELyljV0aeOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2hQAKCRDBN2bmhouD
 1/c+D/9JCP7uMMFoU+h75eykrt0KHmHUnHV3rqtg3g7Ut1d2/As83e5bk85vikvVmZM/NczFXe7
 tQxswgbhKLPilQU4gCP3Ga6silueQpxzqiLbJaccYmtFmcy4rr0I3ATIJuzeZ+xjLqKsMvlDsBN
 5CciXjKG5O5Br5wwG9eSTc/INEM73B0rn+881EzVNAJtEBSP1fNhWwkx5nIiBvGhEp49M99L5nS
 Bxm1JS8AA76I0eJm+s3lVShXx6sccqHmnDTkkB6m8kAdFeJ7lqn0UpVpX6q93orxxxwlAPeVs92
 gp4l4zUpAWVSv5rvRJCGzn3CRbKUXlJ+XXT3EVZsRL4mvrX4OY18izt1M0rKQ2jLVDxHs7pKBKF
 WZMNHrrcyTlCIQ7WSfVzTKuXZaeUtqQezfcYz4QJu73AoUPusr4JilaxDmzkvLOvxaeGWx1aQA3
 XxTSCpYcLEW+07K8mVmDNCtsc3UUybPPwSxVRYBMSHfr0R/Yq+w13B92RZUz3SvitQ1RsSGFGPP
 tZPDshniy8mMJMUivX7pjR39HjGg1DJXYUG1sch9D6IG+YQgxZvHQ5G9tDMnhlrjry3n+cjsAxb
 tBNq5GvN/JX4WDvzpXbCaXdN9IH2zgxN5gPkt0cindxysAHiXqL0N4ohP4zkibgluS7P0+DFsIC
 uJx7nBKwy1ooASQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=BOW+bVQG c=1 sm=1 tr=0 ts=6967b699 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6VTnscBjb5kX48BWP-sA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: E2mVIznb0YP7Bxyfb5WBkH6fCMFhrrFD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyOSBTYWx0ZWRfX/U5PrSXPEq64
 nwf7ePYY2AltC3VEbrWE9UvyNm1zUWj12r5vXwI/JodDxwxXMWzRqrRwN2e2iTC6mTsELKKT8qT
 9K6XYHS2H1V99AG38KZxa5Sm2YMwfCN5op4HnWhGMqhmiRfHsMpaiadiLfDeeDNTcIP+pC8p3Us
 WJlOYccgK3GUke0kUU9qXci5C8gj/DhsyVoN18QZxzWyBi43OfyJg77euNAUjVObiKHj+Gn1Uu3
 siWShl3catAOKnoaolTQvYCwzy0sujFJJ3dRUexFsa4Kai9f0HBjCzrgmvunm8Y+UTd7YRpI2L4
 xmekI9U3XA5gqIvfIhB3UkssfL9Xdl8/6iL2Z7FJq3UP336UUZhZOVr/OCpnD7I8kSBJv/xvaoC
 XhDz0ZdI6HqgPFTjzafgPJ6iJKOIEa3tx1gFlSkIInHXEL7nPk2vkOBsGHCk26bKQW8MR2jY9Mz
 3X26zLsT8sm1n+4QM+Q==
X-Proofpoint-GUID: E2mVIznb0YP7Bxyfb5WBkH6fCMFhrrFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140129

Simplify error handling (less gotos) over locks with guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index b6363f3cdce9..7a6cb5f502b0 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -264,19 +264,17 @@ static int sgpio_single_shot(struct sgpio_priv *priv)
 	 * setting.
 	 * After the manual burst, reenable the auto repeat mode again.
 	 */
-	mutex_lock(&priv->poll_lock);
+	guard(mutex)(&priv->poll_lock);
 	ret = regmap_update_bits(priv->regs, addr, single_shot | auto_repeat,
 				 single_shot);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = regmap_read_poll_timeout(priv->regs, addr, ctrl,
 				       !(ctrl & single_shot), 100, 60000);
 
 	/* reenable auto repeat mode even if there was an error */
 	ret2 = regmap_update_bits(priv->regs, addr, auto_repeat, auto_repeat);
-out:
-	mutex_unlock(&priv->poll_lock);
 
 	return ret ?: ret2;
 }

-- 
2.51.0


