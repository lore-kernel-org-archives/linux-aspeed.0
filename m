Return-Path: <linux-aspeed+bounces-3384-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DBBC9830C
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:21:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2c0bBQz3bhq;
	Mon, 19 Jan 2026 10:21:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759821;
	cv=none; b=hmCH1AiQsBWRHXq2tWAiiMrzd4fpn5YolSh8mbjtCxtP72ovAQkH3mYVGHM88lIzvg7OTblFpD/HlT0FkfLdKHV7Wf7A5fujVkePRn097S7PJY+hY8/qCQdn3Otm3x10HcAMIBQge8WhOV/GkfnH69dSKhZQVLu8TmwG5LxmBSXzigaJnxZ26pWMOpEDNlKgQ3PA0LAN6fyP2XTM0is5NIdTwgSWLqkKW24Qe12hKELFLyEbMyolDGZxtiHHw5qEwqNuRCBayiXhSGnPG8sfCXDOiNp47M5RMixPAKRJLA+PzRWVrBOuhrWslN3AvEfZQOuwfzSzseOJ3Gw1ApYsdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759821; c=relaxed/relaxed;
	bh=VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WECxWiilKaHPytLG/kH39VQyZls7/Fz+OsC42U57TPlw8ORR9udfoox9v72mYhX3YPQNx049ZsPy9hBkfVZQlYDyGJkhVUkx++uT4l7W5e1JWXFx6RI+T4pA05kXioHfjMhXFxuN9Z/jjQWBQ0W4XydqQe1rOihtDymh0INiDVskUrhk1nYIPYdSJhRr8a8qdoj5cnFBHbL3m3hER2FAAVwZA6Hkhnq0ZQnsrk3TMMwtTWDdFrXaln9JVsXkoYg4RXvGuBDwY/g/OP4qoiDhHW+637xkXB+Eq1b4PRNzSCM56Ps3QvonTAEd54GG7uy9G6AOveSxxmmCvO0b1qkP5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLHmcbh8; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P0zRZzjA; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FLHmcbh8;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=P0zRZzjA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM7x1MwFz2xSZ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:20 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IBPZ4b3019878
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=; b=FLHmcbh8VeT0Xx7u
	ocCWXxIuvjB9tBx5LxiCDtIBDccJU379nP+UmbRcoyBcr+3edNEdpueWK9J+M9dg
	On/6tG/zQrLm8kIshV6N+0lPrvBMlNib7FFNeOZ8S06q3klUrsezMEtoWQSE7x8a
	iEZVX+2oCVORqUTkeyErZZCtqx37t6TybdAYQxnbiueXwqeFCCkNWbDhB/sk9zJO
	wyGw/a/G1LG/16y68VMQZIcKCntDh2BsmDjLvW1Mt+2eHXhh9/2Fc79ypv3cnxJq
	yymNkMmzrvQoaprecP+D3OwcUzhJd+k9MUIKezJvfuCKhbJaAMB2BIcNG0+2rc9i
	yD93uQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br2guju24-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c5297cfe68so689276685a.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759818; x=1769364618; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=;
        b=P0zRZzjAv9E/7M7G3M05VhAH7y1dh2o9gTADclbRNHksJy7vvNOd0ZPGtseTbevFFn
         c7e5s86pFQOwu09YIFeoQHziYiRCCi0FLTWbpqZG+Lc4Ig3obS+tT/0TB+entYPzvTp6
         a5GBLledwK+XEx4QCJzu+Ph7HP1UBgbECZLD6N3SSDE6paw9nN7Xy0/a9qBOsep7yf4o
         EzzJGi2kkohx2f9dXdWmKW+RIyv/BMbOy6ptXHnpeu5bG8V8wLptnfCNb9UQ+dazU43w
         TgSte1WQzHXiAZfYyTb3WaNvsFCgV0T3WQpHLyEI7k1Ou/xOHSBLLMYNp0cppmyPU09a
         Rjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759818; x=1769364618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VMrQrzLzDincZEvSf3IY0LWe8Yq0vnY3RbOd9IgAleU=;
        b=mSWQK5wErxy0AE1Vx4sOF9VD55Fbz2YXAMqWSxI6cETkfIJ6E2NJulsSAWm5Qlmyia
         TT6emjfw+cO/IRRV6oqrSbKZIgcjV4FgYeJbAOFdjGCqDxlKDmvmBKHWdd/CwRLLXQpd
         62dCjUd5/ok3JTzkuBj9NtVlNqAdn3xrYQiq3R6UFvAWtHGdJ8E2caK490wGP+lQEC98
         A7iyCXYgmRp6yTP4+X8WDrFQlooFVFaanW60C5TOm+BrgOWU2en9pdr37LH/0dei/pDa
         oPydtu0z0aN9S8ogZkJVDWP6KXJjwVpAnAFGM8T8o6wchE+JiR6XZHUrkt4ChwICOKz4
         D5AQ==
X-Gm-Message-State: AOJu0YwtVOqY5j1Rwj+/nxmoFH6oHk7qEHggObAHq/kZFZT271lGqtHF
	O3w0V5f3GyptNTb9GBfuwMVpzihsunh0nuWSLMrNRIii5ft2fy+qF5FxRQopN3B2oM+2fZZ6aUz
	2xccVuvywpCr9KieqSJqYJiXOcIle3pOu7XGj8kwt7dp80bDW/dkFoTWNrn8kOmOO0vGU
X-Gm-Gg: AY/fxX7MHH033t1Iix0vUjFlGMMqOR3P1g0scF8sk/Q9pnX4eAozOf96Wnv9qhtNxSU
	BQIzmVjP9ZM4AeH7vITBXi+OYWgAWLBY2FQcp3XPR5LAb1HrS8gUvljw+zSnKeA8SHeZgPbgsZ6
	GDUaFuX+8djnQ0FWzGnxO4LRxwV8R+PVF8YSYkcc8jvuPNUFWALEY430OlhkGxW61ltDod/ksf6
	Mkmvl+ugxHUoC61LPk+zNa2dCJBhIZlva5AgXLGGA6rD9ewMKrP5z2UW2eN1LwfrW2QWDW8542P
	OGCPBjfQnf3e1UHJH6tCuQGlVyUQU/319+N2RQd9kDZ1Bu88dSB4TarfObPTFiYm2sAdO75ovwr
	lk0phK89iQkcYHoZpSKI3rI/8UcxL6fzcPA==
X-Received: by 2002:a05:620a:4543:b0:8c5:af6:3efa with SMTP id af79cd13be357-8c6a67bcd01mr1262133085a.86.1768759818327;
        Sun, 18 Jan 2026 10:10:18 -0800 (PST)
X-Received: by 2002:a05:620a:4543:b0:8c5:af6:3efa with SMTP id af79cd13be357-8c6a67bcd01mr1262128485a.86.1768759817837;
        Sun, 18 Jan 2026 10:10:17 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:30 +0100
Subject: [PATCH v2 07/11] pinctrl: tb10x: Simplify locking with guard()
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
Message-Id: <20260118-pinctrl-cleanup-guard-v2-7-bd36f681bdc0@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2163;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=adtV57CgOwnY60Si6YEP4k65ve4WmCO5x4rzf1ZqeaM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSH0P3baB5JzE0xj4EquivvpaBBrqdpm6amOt
 juDbwiBC2KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h9AAKCRDBN2bmhouD
 18o1EACUQyCgNzHZcDtTGGjP0XngZqctytCl/BhtXdiN2scGWH47PeJ1EbokGmcu35oOMeMoF/P
 Ai/yJjffW+dvyctYiUkUjdX8qhiC2jEMnBnR8HZEw07kz1ropOT3VtM9UNzcOP4VVa6XiU986gx
 +A9IxfYMZgbHYem1kw5uWedXNzll31yR6NXl+qm3YmcapiaWrXfhMQr5W3+Y014NvLqFh0h0nY+
 VxNPqKS0K7Oc6imDFiXRU50DUa2PRBddUY72TCkg8IbNE9LNnC+IouRZfrpjgzU+o1sRF5zlhhE
 I42rY1W2TwyfNm25FScOIOwekUr/tt7XHK3Q3KNa7vNG+uurb06yeOS0NW5zEIh+fH0e0tevRbL
 5txnHIVmMgsVP9qzzc3Br1lDZbc52FUcLV7vvC9rMpyHoyONur5eBHMB2UKz3Xqa2NBtZPpWsFo
 wo5+VFlpkkdh5y2iBoS1iDvXQLvtiqBpaHj6Suu/4MiSLX+PkV0aId7KrTqfcC2PmJjOYVi5Q9Z
 vShD+pW5GDt3E9qbXvJRxs0a8bvIwVXqG8pg4P9bsL9v+rGt5VbCvR6FyNIf67jL9QRcUvEn4Px
 54ALdRQJBLaZ4OkpCq7oTGr0tO4yjqNJDKYKdrn03h/zNzPbiXClpfTtiL9qzncdjmoS9IgEOV/
 vTudhlAhqE6ovOA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE1OSBTYWx0ZWRfX5Ram3rE1MlUN
 BwLTndypmT8ZXmgu1q0osrnSgMYyddg3eCEUG+YHE5oGJALkCVmt7mjKy77WfecSUzYdOc5PPPZ
 i11mf0mtiiFW7QquD1LVpY7alcA9iJkMig+ivhVfKFyHLLcn91tjctCP2i36e84ViTgx4uQFnzs
 NP9wE6qFdFwIuCB5gj5tFVLP5O3K1q9QizY5Ja55qL8PIKVT3XwgmZhLLhiK7h66OYZQma6iqQL
 1knZtXUjJ9v+930O6q6rVaM8e8tCCFgJI9E1C2uvsCSEp8wcYCGzllXyuT46VNvFFmkdfj2YlM6
 Ep5HDT3mdd55GFuoI8yjZQ0U40med3HZVRUJlxrLE8fq7xbxo33/QeF+FEtoUDMmn+XUP9OL3i6
 2/BecNC+a+wFUuaK/9hk+QKN/35DrGTdXv0GO7P42QHPD04Kob+++9Wv9OtK1EYCI+aBqpSPxxU
 5ZiZVD+Efd1nv2//bPA==
X-Authority-Analysis: v=2.4 cv=Sev6t/Ru c=1 sm=1 tr=0 ts=696d220a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=fB2tTgKqvhDdEbG57mcA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: -bsTBLuZw8XMzQFBCBDPQKHefagXwlku
X-Proofpoint-ORIG-GUID: -bsTBLuZw8XMzQFBCBDPQKHefagXwlku
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180159

Simplify error handling (less code in error case) over locks with
guard().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-tb10x.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
index 129fa51d13b1..3f581404a9b9 100644
--- a/drivers/pinctrl/pinctrl-tb10x.c
+++ b/drivers/pinctrl/pinctrl-tb10x.c
@@ -607,7 +607,7 @@ static int tb10x_gpio_request_enable(struct pinctrl_dev *pctl,
 	int muxmode = -1;
 	int i;
 
-	mutex_lock(&state->mutex);
+	guard(mutex)(&state->mutex);
 
 	/*
 	 * Figure out to which port the requested GPIO belongs and how to
@@ -642,7 +642,6 @@ static int tb10x_gpio_request_enable(struct pinctrl_dev *pctl,
 					 * Error: The requested pin is already
 					 * used for something else.
 					 */
-					mutex_unlock(&state->mutex);
 					return -EBUSY;
 				}
 				break;
@@ -667,8 +666,6 @@ static int tb10x_gpio_request_enable(struct pinctrl_dev *pctl,
 	if (muxport >= 0)
 		tb10x_pinctrl_set_config(state, muxport, muxmode);
 
-	mutex_unlock(&state->mutex);
-
 	return 0;
 }
 
@@ -695,34 +692,28 @@ static int tb10x_pctl_set_mux(struct pinctrl_dev *pctl,
 	if (grp->port < 0)
 		return 0;
 
-	mutex_lock(&state->mutex);
+	guard(mutex)(&state->mutex);
 
 	/*
 	 * Check if the requested function is compatible with previously
 	 * requested functions.
 	 */
 	if (state->ports[grp->port].count
-			&& (state->ports[grp->port].mode != grp->mode)) {
-		mutex_unlock(&state->mutex);
+			&& (state->ports[grp->port].mode != grp->mode))
 		return -EBUSY;
-	}
 
 	/*
 	 * Check if the requested function is compatible with previously
 	 * requested GPIOs.
 	 */
 	for (i = 0; i < grp->pincnt; i++)
-		if (test_bit(grp->pins[i], state->gpios)) {
-			mutex_unlock(&state->mutex);
+		if (test_bit(grp->pins[i], state->gpios))
 			return -EBUSY;
-		}
 
 	tb10x_pinctrl_set_config(state, grp->port, grp->mode);
 
 	state->ports[grp->port].count++;
 
-	mutex_unlock(&state->mutex);
-
 	return 0;
 }
 

-- 
2.51.0


