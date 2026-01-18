Return-Path: <linux-aspeed+bounces-3381-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC6CA5FEC
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:21:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2X59xXz2xs1;
	Mon, 19 Jan 2026 10:21:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759828;
	cv=none; b=IZinsQrp9mbV7iU3GG7QO/nmLqfsI6VSnNuKoN3KjxPHBfooozATq2wvFm9fRWZ8BlyNJH4Ni3omzMcKsFY2MRerGz2Zfts7BTzkBaDvtrUFK1p1/c9styPDPk/BuXBgE98us9NNv1VfIQBt+9dANWQhCPokKN7jthUNr+1DMi8v0l3gBM8cuQ25EoaTgUSn6jHx/h+YWVQ1nklKoQ2qZ8moJNzdHFApYSoIUziSs6LPWRtP9gIJDdQl7yJt5KWa8NTjhJbtdQIEhHRVZSemZfAW2qeN/iBDJhlXgfk/FVYketTCuZAFzNrTRyk7KJLKLHoExlxA/P5yf8Jxt0qbSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759828; c=relaxed/relaxed;
	bh=UER+4Rm+CTn1fc42ps9UZK/VrM2V9tBgnOrD2NvWQKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G0ipYZ9O9rgjm79p7L66sFSUONQG3YR75JjGUlauNObZsBLT5BCef0AOXc0WWlD4QeO8QFGXQ1BxRN1XmTE13zKyFQ5N7ZlrbjT+w1hZctlxVyScDHYygRo42haYgK/nrwYexHd+GrdIhtxg0uGCxTrT5hnjMHFgnacTlpJNJmBGw3wQWTUEtscrpeLN+tKzRowcUgQh/OOS234avK5YkNzK17vxi3zNWoHhry1i1xNFTYBy/M2eODI8goRHArevA0NGwMewivY1SURqRrD5A4Axs29iDDuOgwCHds3Pfnw9PVHyq50UfEULQbFBNDebhEjjNosoM7/4QURTLvRUpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z6DB2YhG; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bny6s2PR; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z6DB2YhG;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bny6s2PR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM836PN4z2xSZ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:27 +1100 (AEDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60IBxPTj3175767
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UER+4Rm+CTn1fc42ps9UZK/VrM2V9tBgnOrD2NvWQKQ=; b=Z6DB2YhGkaLCOu3G
	dvJzrF9MGYlT25uf4akGK2B2DlOvGRwGmJkrWOY3hzsMZ9UZKt9Edh/p9bkWGcRw
	ajdURbQ8XtREwXTXybLIEXImTWYYnGNwOm2JsNhQGOtXgrTJfP0JCqqeKjwLBLit
	VU7tDcy+orbSwYYr5ZET5qJ/GHTAYICe8F06wtnrAv9XQ+ZekQSdskicVPmsod1j
	jXwEuDZ/7cpau5lyz9sJ3ZCk1xTKJju3RqwxrwYerQtNGXL4GV9TsZEV2RI6HFgM
	vUIkGVwtgZpSNCspbZo8ypNikiv8lENoW2W9dQ0qDWgj4faSZJsRXaFDd7Up2NXc
	o7I//w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br36darsb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c6ad709d8fso397161085a.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759825; x=1769364625; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UER+4Rm+CTn1fc42ps9UZK/VrM2V9tBgnOrD2NvWQKQ=;
        b=bny6s2PReVjsscFcDsOfEy/nbKlDQqc9KI7wr9i/9LUDSAIK7YWklUBrTWzLDkeu3F
         3bO9mBgMFPqX3NH4dXPgRuyhkI40v/0CTEdt1hE2cnxYVdNtTxK2r60d2ZO07IIoXXtT
         WintDYosmVEqVdfiCPs3IxFzt0k2j932/LyUm68jYYfpxjIw0/hVrCS9wzdy8yUUJtA4
         GDFZyQin3pLcB6tPcbIJ6alvi9rwzB8/QSLaeUw5jtZHlCbS0YgocK8EPPkrFE812RZz
         ShUMzJcwvNob6+9j6f6wYbki91UBmjAxpB8BfxooNeIwjaxolNPNc6NRdZTAE8ashrpL
         CKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759825; x=1769364625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UER+4Rm+CTn1fc42ps9UZK/VrM2V9tBgnOrD2NvWQKQ=;
        b=pSwm30rWFDxdCF46dAh74jDThPpgdojYcFVh7s3daAwSC2ar2q8y7DfpMEjTMdJXkT
         9ACqsIPS9EFdVMz586dWFISXmpOfkfXIYmNPVex/2TsaMWar7bMCC1XVooMP1zNV/2YP
         JhJ8LdRrlK/iaAbvuQLBO5HCqDO4yHaYyj9FZj247ZEE16YjB8r+LjkREphH3sFCfGtv
         x2Zp3V2nuaPws/FeX8meQ2rzv/cSaWrwqMnb64pSSr+b3O+/ID4ylFBe9GGqgQ5HbEZa
         6WuHs0oUBPNrRlPqjfF5oNG8xuCir4XQhKbT/CJNE4UpuqSyTp2cMSd3nEzkKcMEp+dQ
         AlUg==
X-Gm-Message-State: AOJu0Yz8UTbvry5NyJ7OwVrlCKRF29VIWky+RplX4rDydx6v6DwCg6R2
	ddSPOwgGBrK2EoH6i/8W9Li9Z4Y4gOhIZ+K1i2nwG93GQuGP11tdMVW39sj1q2svdxmSFmfSW0E
	oQ9xZf6G9H3JiStyTUq9p6uwZRveHOX4nb3aBOI7AO8M+JncMobnkpeN7lY2qkL2e240q
X-Gm-Gg: AY/fxX6dk+TGRvzSIxgsvgtd1j7XkSLCTvzydixoAkf63Wsdfn2LfsHaC3S/mwTXha4
	A0Ok7ZQ5zyju2v0ETIC1O25A6iealGmAmj16z/3MzAbv34IanU16oteB7uBbI0AEmg/O4/RUjSY
	hfSOMpRyBfRSHkNOcwY87tZmsOrB1kB3+VlzBbWvKWBJ3OIom5qEIAS9rDaM0nH+RlFeocvm2We
	9wRJMfiUNZHMbcbsQlJYYuSnbIdS3ONfRvd9BP+w9uYeIpjePq31ud3FYk2HQ34O/8wclMMwnf5
	sdQzXhz7iAOF6E34aQvseg89YLN2qUmlLtBTH5pi2MKd07gQ0JaLjD5CpaCwqrYLhZFLbXQ3bo3
	2tAiY1+NL9kxTSZwJ4QxkhThekzFGwRgrOQ==
X-Received: by 2002:a05:620a:31a4:b0:8c5:3412:3aa6 with SMTP id af79cd13be357-8c591a1d06cmr1679914985a.42.1768759825065;
        Sun, 18 Jan 2026 10:10:25 -0800 (PST)
X-Received: by 2002:a05:620a:31a4:b0:8c5:3412:3aa6 with SMTP id af79cd13be357-8c591a1d06cmr1679909785a.42.1768759824643;
        Sun, 18 Jan 2026 10:10:24 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:33 +0100
Subject: [PATCH v2 10/11] pinctrl: rockchip: Simplify locking with
 scoped_guard()
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
Message-Id: <20260118-pinctrl-cleanup-guard-v2-10-bd36f681bdc0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=xHpKv/L+LPsJ9X96+TG0TkMyLzJ8lmjqPrbjckpJnLU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSH2V7HCVVZQA8nE36OlRFJLPIeFm2jrQH0SA
 voGEok2auGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h9gAKCRDBN2bmhouD
 138DD/9yYDuntgcWTSxWPvfXFutn8XLNtbjiww7N0//+LCDsOtjjM92dz6ezguNQS/QHM98IHRr
 SF6pn5H3zt8atlHdhCPpyf3x3oKRSwOS0Akm92SgBtUpRXGuMiq+7O2MsLdR/tIUF6gTEgn6yFV
 84Lk5zDvgwOi0QlMHAVQZPovb6h/vY837EVCDSRCFQDUTEAR7na7JozMG8tp0VE0mE7bIWwPT/f
 v6lwP4dm5xYRh+B6HzZmHXrpwVUi9RbgeRK/PNZNadB3uz62KT1T0IT8R9nZUQtX9G4FMRwD3xH
 P5t30O/Hz6it1xvrvw1Lu5f3+AySnjjr6MZxix/zVD9DGKJE40H8HH7zTSSsREL4FwUU8zZS7HX
 dALPTXy6us1q2unNwiDi6kI/AVXWCCZ6sGl+XxvmbSBYYbIWREh+WyDt22jBLH1KeIKQYb7jH64
 SyxqJFMRWZNJsMGxf5H4BjA+NqW9skDWnXCNH2FnpIxnCtdb32i8yyU24YQcB2qy+UqVOj/UGme
 M5VDHJie/HU+5EggRTKsw7A3HWxLO/5lpq8m0Aym+vl3+6ldnGSTLTfSdS07z4/0Eibgnw8tPUH
 +vVzE2zpO63gAjhez3qAdbhnW2A7TSbUiCJyYbYcgetBXMa20Xnn0pQEThXHPYBZKIK1KuGnnf6
 /vUyVHqLHNNxN8A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE2MCBTYWx0ZWRfXydKgO32jRMuq
 3RIRowzGj+NyZdPJhFmm+OlgFXJ2koqSTr1UGRg+PR1N4zgbpDnetZWbKZ3jflzB7Fn6sDg4TPn
 UJPB9t9qGgX/VBsbejBmVZOcp0CzeADnFkeT7GuPL50TCsy49U91G9dICiRwwuxr5WypiYIkxaq
 86BGKojp90nWylHigf2eOVoTyN4jA5Fq/5AW4BCmuybSIXrbjKCZp25yM0R9OqFCrip6uV9MGrV
 I/6HaD7k2Uq96tqo8UXBdGUL6XCU8M+/6CF3ahSd3RtV30K59NKI8vXOFScy/LhtzelaQJJoxoA
 CO7DF68cWZvMjWm/ri4JLEsm9r16aPdmpDfzrYfz11HSKHvPyajI2w6VaPO0XJ6LXKOJZ9lvuRc
 OLSSgC8YhVAFpFdItzkAt6urFnfw6BLPspK2vPDKMFbNuWkghDHInHaSnvoiNTvNteIn0T3BPw3
 fYQuo2cXCshF2lmfCaw==
X-Proofpoint-GUID: qBYWcT3L7AAAGpVnxVF1jQMs3wOEBh5w
X-Authority-Analysis: v=2.4 cv=GJ0F0+NK c=1 sm=1 tr=0 ts=696d2212 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=zo1y7j5tH0XFdPBYKCAA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: qBYWcT3L7AAAGpVnxVF1jQMs3wOEBh5w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601180160

Simplify error handling by removing two mutex_unlock() calls with
scoped_guard().

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-rockchip.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index e44ef262beec..bbe1cf712965 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -3640,17 +3640,16 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			 * The lock makes sure that either gpio-probe has completed
 			 * or the gpio driver hasn't probed yet.
 			 */
-			mutex_lock(&bank->deferred_lock);
-			if (!gpio || !gpio->direction_output) {
-				rc = rockchip_pinconf_defer_pin(bank, pin - bank->pin_base, param,
-								arg);
-				mutex_unlock(&bank->deferred_lock);
-				if (rc)
-					return rc;
-
-				break;
+			scoped_guard(mutex, &bank->deferred_lock) {
+				if (!gpio || !gpio->direction_output) {
+					rc = rockchip_pinconf_defer_pin(bank,
+									pin - bank->pin_base,
+									param, arg);
+					if (rc)
+						return rc;
+					break;
+				}
 			}
-			mutex_unlock(&bank->deferred_lock);
 		}
 
 		switch (param) {

-- 
2.51.0


