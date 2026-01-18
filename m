Return-Path: <linux-aspeed+bounces-3385-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B70C98315
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:22:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2d09CSz3bmM;
	Mon, 19 Jan 2026 10:21:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759814;
	cv=none; b=jh9csIprVoErP5yoN4etL1A3wahLuFb+vbuBeUsNLreSI+UlbviHFVZdZQU2TN1x95uisA1ISRTQo8vK0TsxPR7Axb/VW/gEMaNfc46mC0eSulCmSYuc69YfaFF6dkUg+fICw+A6i2fKgG0THy8U4Ps0QlGvPUrhMX8Z9YVFWisdcHOwIsVacK7L4+ssgv00qQ2iFqWn+3VXZmjgDkaJeIP72mdQrVz3DKhGa7jjJLDX5TZD4a5obZCeNlb7sarnP8FcXCPGv/dC/UXKux4l0JidLRLVdDJalQahDp1FCzc3nzqa4W/37CUe9jyeFayjtjzuAYsbt7SHMbX1WUC9/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759814; c=relaxed/relaxed;
	bh=Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNw2lc/0/6l6lcCKDpq0y2+CoLXQbc9q0UiCTpPC12hAI5+oiQBdO/JWUG7W/4/0Cii9ORkPruyyJgiqjDsU3sE8TxK7w7sy+xAD8b5/n8vQIBrRCBUel5nzPPrG9R7KjNY07QORgyCkTcfCKzoL9EafRrHYZkH5nZleOjbCX8kFzzDSJcTE7FkhHEcYVmkurItM0n1uY+j2Ztp08NpvyObSq2OulGYJxdWHUYOs+xgj1sG1rp8oEE7I979tn9i1u4FCsL7cImzPd7HJeP2VqG9cptGXxJLY1czQ1P5ohPGcENfyNaFpCa/OA74+2Md+SycXVy2VQleED3zo4fLyvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EKd0XTCH; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZEOHW3q9; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EKd0XTCH;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZEOHW3q9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM7p1HjKz2yFW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:13 +1100 (AEDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I3vKm61403634
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=; b=EKd0XTCH2anl67j7
	+xoS3zAwyuw5gexTX4UDZDbMLnC5kc49ZKBvo/PRSfX8H9/mojr8PFpvgc3ME88b
	6axcSF5oETo3Ez0pN8KFbvoEFyhPrF7c+uSatRaUEvMLzXAK644V1AGsZn56bvQS
	bCZLsjvXGEqpYS3LnoXqvUCuqUI7H7Y11WJLUaxSPHHwguRGZ4Q7IimJmipOt+50
	Q6aw2Gwamt/7NCO5mbtrghH/O7wwME0l9ThG+ASTltN1oWwT7WSEvV1+2j1EvAR2
	nzqjOBiZ1kktZ82XgQPuWYmITvwpCe163Q9AwYzYfAfXeJQ2iw890FeCl+fRz5AT
	mTlM1w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br2t72r3t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a2ef071dso1092443485a.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759811; x=1769364611; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=;
        b=ZEOHW3q9xx8o1D1nuBFHAQFgeCN96+G68Xsih4jNZlBKXv7ZTxNyRh1Vc5ExVzkfx+
         lUkaHkgbAEv7OZLw4QcklbjSBfNDahsq281L5BL9E0PhoBkLczyDmbaztysjV3s2K1We
         sixG2SVaE92gyRU6+aVPgcMOW1n9NbfKyI4uivSV7a4Xz1eepbXZ8FIZ4ooHMOS+9GzS
         jvVb5nx2Ifr22HOGGJ8S6BBftduln+CVEIPI0sTo4UIGyB1YHfNNt7KGtNYQGsWpFIfu
         7FMnhkIxTN88iR+BxIQhdGm8OG6wnWrE/4DWMPYFiqiKDpRiY+FFEp/+g5CpT6/E3eSp
         PuHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759811; x=1769364611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=;
        b=Djv3UkRBfHUMp4yhlXRtRCZvUdaNbzxIWIXt3D6oeftUZVR7e6tBnHdWIH+fZFe/LQ
         HmRRhrR+TErFwSmQ7ouSgqdK0+3TWnIKCpjKGPY5thi1dObz4on43pJRfsS2NlfE0E/w
         l/nbLpMXAeQ5/Y7nQ6PMjWux1UWAeMzjQ+e/HMOgs66MVsmSzr5sESn/hMm7+ATyxTRL
         sWSN3uwEtqrjqEKl8++aR6T8EzZfCpd9FZf7cHqw8Ph6w2cL+Tsrhwh1302a3aE+jIad
         UB9SgTfTSv156J5SXllGhNy4VM4WpZzryQj+t0Zh7BEoT85qNf7M24GlRvg6PHoUEqug
         udoA==
X-Gm-Message-State: AOJu0YzdQh7hfKUOHUSSQPZwPQve/+iWDZIsQWDYS7QNG3W1IxSYPPQJ
	W/25qD4zx56oDMUlKOINn9IpucjLEyhZRBe4qj7B0wGykY50k1WD+YkilLOaM2UUkifDdQHYhgx
	DOltmbIbf7c71ofIbLZfxVOSR+T+c2MCyur05hWDDxW4EqTtzaQ/KEySCr6ybSGT/iCT3
X-Gm-Gg: AY/fxX5dCu4gwdY4sr60TduLVS/JXjPiAxWWRW4Yu8d6vvaddUaAlkvN+WGGyXp5aOV
	3hBy/e8aSqLXcA5x84CHSPV541Ujo9ehvQHlto41raHPgJ+DM4XcmKOnIDr1OZn48z5kGr1P4Ub
	tNWioU4SftfQXrt4tipN0fk5XwASTavQQ6MFO0NVDqMZMqX8eJ4mw7DZ8UovHcrTM8+2xrnmfpQ
	wUUaVGizPgWRS3MqKIv3lWU3urfLxU0YOgKcJqB2VmJ5n3wiDYfJfarznSdvw9yhQYptFew+64j
	71ZB2Lz8upgVoD8eVbwn4mIukNNGJ5KFJEpKcYSL1o2zTquaZ1JumTX2si8n5FCISexLGKfPzvS
	7j1loG4h+SpQrJ3gT9jI+fJZp40Mz07I5bA==
X-Received: by 2002:a05:620a:1924:b0:8b2:f269:f899 with SMTP id af79cd13be357-8c6a6956472mr1391331985a.56.1768759811395;
        Sun, 18 Jan 2026 10:10:11 -0800 (PST)
X-Received: by 2002:a05:620a:1924:b0:8b2:f269:f899 with SMTP id af79cd13be357-8c6a6956472mr1391327885a.56.1768759810821;
        Sun, 18 Jan 2026 10:10:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:10 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:27 +0100
Subject: [PATCH v2 04/11] pinctrl: amd: Cleanup header includes
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
Message-Id: <20260118-pinctrl-cleanup-guard-v2-4-bd36f681bdc0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=775;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=KS2A41254/IzptP8+yKUiwH8wnfKT/gY+cirH/V2Wao=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSHxcMweZ49Q5Nba1wrVt3CAmG8iWHmyaxcHb
 TNtiusHLMCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h8QAKCRDBN2bmhouD
 10MfD/9Y8BgVbkm6bl+36BXzMgv1xbm7JsRk164MPz0v27NRR9/A7MTJxMXT6LNgShVq1djSxge
 6g8uCxUY/9zNFfEZbrbUevJi5cHtHc5/YUTCSNnot/lyVENX5O2KSCx3dYOpUdjrHDF8VX8ybHW
 wzM/tjZOoVQ7+gYxMukxqt3s8XLQOVct9PlD6qtPZmiFE1vab6GQQgLNVgM1lOYylEfR2ldNJXs
 jXDMtydYwc+g2dbP9e5rnGzbL2XkzK9qGia8zw1O8+ri8yvQ/U9eaHS+WXwTO7Vlr1QAxEc4oUC
 zKbv4wtZ1zeayUoWUv1YYDBGknxgFxwVQ+bjAyyLW+9wq3v6aKLX2CCdb7vhkv9IIbgJ0ieuMw0
 xixdCHOWfKQ+OYzmelQ7pXLN7RTHkKO8loGnPsXOAVHqo6wdt1FOQH1bb4xGl9Pd1K011ZOn4sP
 piveUlRUfW37nPiHBDROLc5yASzQBPjKA06V8RpaHwfC7I/9bVbiBuGyvVHdGhk6LBSFFKEjrBX
 UljGUMx3HN/A8uksjr0su24ucX5chRlqNVyncRJqPaYjbJAJ0zFKM64X1r9AnLRwEVfas7sruYn
 VGBFODgVsHuDAOcu5XDZBnuzDmqv88C04tW2Pve5Yakzf9c11d3W7hQUeI1nroie7c8OQHhI2ca
 a6OcgYeqNAjKKjQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Fdc6BZ+6 c=1 sm=1 tr=0 ts=696d2203 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=tMXyHTyi87mTYQFNLaMA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: VfluDPmnpvM5CSw5v-HsZt7x2z7wdIS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE1OSBTYWx0ZWRfX2jqt3m4HBZyM
 BdZtBov4n2bQTnVwefJ+xNbyGNIyn96HsEF2eC1scfTI2cpN2RW5xTtrX48fCySgDMvCqLM9N2S
 nNHmhGH6MMlu0uF8SFwCRaQeKRky19HOuChqNdY3iX2Llu40nMa4exkl1JG1Cm0BH65sCpCxNOu
 2gP85tHKqAvwK2+CGrRdukgzTpBNxAuroIWhUkg4swQaxqlcxg6l0xPNp9oPvlsU0Vx+H/caE8i
 r66FJv5EkbKiyPDhBqOidCu90BswHe/kplbqWBfB6JqvzvJeujcoHzo+PmPHjMARrzQIa6QXEn7
 wf4ks4FgbJt1NR2qCrYn8jonZqcqWEcjH48Kr2Yqh5mpZDAtvuv8WFF7VyHgB0lt9lvXBvFyqxe
 wi/7RA2P/pOcweOAS4Zvrd4y+wo/T/F7bRRWz6sVXYxwky27bRDHBYhUVRVrQSnjWQY6SoYzkZ6
 A0bLR/W689D501o+nuA==
X-Proofpoint-GUID: VfluDPmnpvM5CSw5v-HsZt7x2z7wdIS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180159

Remove unused includes: no lists and mutexes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/pinctrl-amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 2dac5c71eb00..2af94ef56434 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -21,11 +21,9 @@
 #include <linux/gpio/driver.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
-#include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
-#include <linux/list.h>
 #include <linux/bitops.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>

-- 
2.51.0


