Return-Path: <linux-aspeed+bounces-3322-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510A6D3CC82
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:25:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds0zk0GNZz2xrL;
	Thu, 15 Jan 2026 09:25:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404628;
	cv=none; b=DbBupiNpYU7Q0vrfWCey68aMZiWvXFseVV15+K2VmL38hFwMK7BRePoSHZYc9tZ3Gc/fm5mMDGXNo/S7v3vWo3m5Ie1jbqO9B8K9A+LXXwjmuzY5pTDCW0khRpMrLi4X/sNZcJvOYXdpOLxSHYFiER/S1+/fB99MNGmmQP1T5M0Za0T653DRhOPcWveuz3HXg9bB1MI8Au5O/dOa+haMknaUtF2uRn75RV2b9Ii9sPzuSlIWvcpw4yvUXSEbryuPmPYXDEROIYm1qaKrV9uoBHLvREjSjQ78Lb9rFdFsSdHmW54CbbMPNwq0TXMHdG3gnOnExEsP++vmf9tCak3pHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404628; c=relaxed/relaxed;
	bh=RTM8QP4WDE86GBG0NkZNuey0Iun+lulG+w2rdXJWnfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgjnTLpdj9pPL0L43YYksJ8efm7ckzkx91BQoPriInM0Sd94mExALvkILEf1572ErOSdxQkYh//d1zSCf9TEL+b5qzelvZTshp9rRsxdA7zs9Q5l4uVq1oHLzXCk1sL9uO4k1XKXKFAjyIf/hy4CPld1CWA+HEZR7LVhcq/Hw33yAcgrINymrXceEDDFLvk/A8kVVx0/2hq11X8gHgzTkMhoIDfc5tSpdN3NtLWVYOh46FsmcdiGh7V/+17f3IWEqTEJML1Pw+0DZFq47bk5qulSJtGyExrI53iM8vDJ9gzu6MwURBenwejecmakqAZOP+wwhxFlBY4mvjHaFomeQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AzCSBoD9; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c3IUq3Rh; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AzCSBoD9;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c3IUq3Rh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnG5jbDz2xYk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:26 +1100 (AEDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EDnmKE2081707
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RTM8QP4WDE86GBG0NkZNuey0Iun+lulG+w2rdXJWnfI=; b=AzCSBoD9J/kAgn5b
	NYPVaY6w6+Qs5o+wVDPdmbCawKNIhRSVPAqH4gl4pai6bAKuHoVYlq7/WKsYLNjB
	KQrB6jYs0vWaY6+W+3SN1noeudRgeyidixzfP+OYATvIPWpHkiBDpg3e23JWTX1p
	4fhGq2IJnlZ5KJqbzP+NLxCB5Fc1xLFL8bw49SWoU1rGDiQ5rHou2y4mHufOcRST
	Ob3AkdvukE7IKJsynwD1ZBbOatQM6y+aklUfu6NiWhUft8INyUsny/4bx+2bR/QX
	ghWJPg8SbaF1jmdhlrH19G4Z/HY6XW41soqrc0WF1wihTWOXPxte9gbGFoCEMnSl
	JSycfQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnu58uywx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c5297cfe68so328046185a.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404623; x=1769009423; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTM8QP4WDE86GBG0NkZNuey0Iun+lulG+w2rdXJWnfI=;
        b=c3IUq3RhErxjfbciEc8i0mB6dBn1DOIsUR9AhBBt8caJNN4cdYDm2gTg1ZiK314iw0
         oh0YTt+P6X1sP5jeL0TDhMak6RsMITSUeqhSSAnxFzpSjEh7urfO2coVUIQduAiy4fFg
         LUHRWMzWVysfnosDnGYMjuq0PsqcoSfFpqBI7OAAv0dQ88ul/ZzzaGRMW1HJurPizqcu
         QY6/ZetDENd3C43oOslZuysQ7EMZSvGyzwbCqXGkvvmyh00Z56w2EH5VxS1K29f4Vltn
         YRVNXsqXAiFOG4S4Sds0lie1kSWszGNyoOiEyGxBMxRZHsMwQmHmlJb/uRfTID96RtsB
         yBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404623; x=1769009423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RTM8QP4WDE86GBG0NkZNuey0Iun+lulG+w2rdXJWnfI=;
        b=YM9gsE107KkTjLUxYI0X61U0Xy+TPSBQYLoj2KyMrqn+aWsg4wF/akB1SynJY5559s
         BPeJgcJlpqYXoIVIz158lon6uC2BzTWO+aobrIt15aEcfUK/SO3zd1/oKmH93kFnEShh
         k5U1ZfvrObXg55j8sZ92nM04PHs3QmBX8LJNT9/qSlBT4y/fRnFSAfrHshzmKI3Qeman
         UsQOhbBr94dGBOU1DR76drAT2uSAKs5lUWVw6/sX7YWnOr81INj89X+gL7QsZdOywIzq
         /mOJoc/6rywHyh3Bssq3y6+VFHTwKb9BMMVZwoiBY0CiuVEmH7VdYgbz5Nd7gdt63wtX
         yNgw==
X-Gm-Message-State: AOJu0YxqRlv8jbdNqHKn7CPyz5kB89mlB/ZZUlb7DZV7D3aOsygjJJpY
	nWofs8V4NWJ9Dm9Rcsxx6aNQaMLo0CqicrcHCdN2Vr2VtjQy/eBou0FRflStCt7OcKkwG5CZT33
	tr7FZfhcsVUutCRjcCQayJrC5ceUu+4ToRNaF9o3emo1y9cAybAATLX3p6njAkJQXmNfe
X-Gm-Gg: AY/fxX7zwzMpxDXuLVmJckYgfa2fmPNClC/GZEYRzOXROxq34yCfMaO0DPH0Rrwb3fm
	zWi7L7Y0JzNZrWs7qvNVEAryS5LbhCNtnBq7NekhhEuwUDD5qGes2Y1/XU/pkLJEOxmQQG4nUw4
	qOd09D37/NMrpmpcLM5LqDL750VD+lnLahUEwdbkZ4dkivEjNSCq8nHgDL4ujQtacdNT1m58xnc
	6em9i6dEUhuCP6uf7GvmqPSBS6BZJOCVBcRrHTVKyJ6nuEBCd9gkBP09N1Lvggz4t1otYfojAqK
	D5ZwGdNdAWCL4SiFYafJ0CTZTUeLJfVHXDXRZEIy4IuBZtF1zWkgUcLkck51OUBDTPMJBCMxtVN
	t+qggInVSK4/HMTPJufy20jfGQ9P+5186Pg==
X-Received: by 2002:a05:620a:2556:b0:8b2:d72d:e41b with SMTP id af79cd13be357-8c52fbdd3aamr433297385a.44.1768404622684;
        Wed, 14 Jan 2026 07:30:22 -0800 (PST)
X-Received: by 2002:a05:620a:2556:b0:8b2:d72d:e41b with SMTP id af79cd13be357-8c52fbdd3aamr433288585a.44.1768404622116;
        Wed, 14 Jan 2026 07:30:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:02 +0100
Subject: [PATCH 01/11] pinctrl: aspeed: Cleanup header includes
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
Message-Id: <20260114-pinctrl-cleanup-guard-v1-1-a14572685cd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=BOg98/1JJXf+vGTTUwHW2mMQjVbfd13nI6bPXirGFB4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aA2bajX7HJFoPmqSFCGOiGBqLJt6NM8LzAd
 XAIqmeyi3uJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2gAAKCRDBN2bmhouD
 1zSHD/97RdnKd17RjQ4GZXnl1GK1sM4fAIbv/Er4l/nCYrCsRStOmpsNfQQNQ7KbiFIy6ka6EQQ
 RmCybnj6DI01+PJ7LKfZjIhsVOdQRCKSSRsSOzZ2sWtH7UtF7Qco6eaNduwhfUDaSknYVE8yIKS
 q89qtgMa00kGUI0EqHfiZ8qCSnSWxZL+xPFwD+VaK2PMANj3eijWok9TKqlbKkGTmMKho7c3WOD
 kkTSfcVXpAaccbQNmgEAkCUer3aTG6Z0QKWdyinivpOZRSpzni6zy3iZTvH5qnQ5okqQ8+u1yVL
 ZcUZ45bRE9Lxm2YaqTb/8FMSOpMAAXKgnB8X6QA+InLQGRJSNoaNEwmu6nNF/vR2K8ztj6axVXY
 0vmcCDYOnJbcX5YBUAIDooVFlUG0XDfrGrUzdObWOPhSE4k/LWR6KvxxHSM13yiEttuiUh5j5Wc
 uyOWQQHPn+CHVSxzd/HqrsGACkpKblq5HaElBupSYgsEcP/sLU1GEEwHHqCpdn+EPpwcITg6hft
 gzyvN7ZCzN1S8gDsA7ykKbGnB5dKBWHADzwQtqQEP8YvZiOnvQuPH0X2k8Vbd6e0GSxIUydR1xh
 u9u70zyMvvsb2RcwG5zaIi3AprWfNihRSpPswPd5WpF2M6sS9zQbZzeHDly67NBW2wG1jPitQdo
 U7H9zvpSdKlaUmA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMCBTYWx0ZWRfX2dm34usbgyA+
 Bebf0gatpEoHseXlAkahnmvdgXJpQE0ZwfjCupVnb+gT5rn7B3HeXrNGgprDJIMfEmjRXS4mfhu
 d7x6T7mPqchTbihsw5jume7Z+3lYkQG2cfdzgteMWky7brH5eUTB/HA6hcAQ+6Ky4OpsGdC4sE7
 jeWC80nXa6yQHhN8zc3aqK88YQhdkA+2SFMcarNEWEidX/coRUb79dTpljvtZuioYazUvpHN2jy
 0cOpcxYuVghKRaQYGihEKDa988unxKFf0V4k5Qo1deVbtHVy893B5VN8hMv/sL/OfHfeVdNuIzu
 cm34tvPlZ70fHPWdlWCv7zCV623UJ2BNso3iXGiQc1pl89OEuj9bU2xrEIk2NWK4b1xcFv+5FJ3
 pJKNfZ9mPfUCOn6BxNBIe1PmhoQ2y9mopVA5HpCEhXyTmMDnfb/wJbV193YodB/pTpzX85dSrmD
 tyX8TG8VFzpMK9rnQiA==
X-Authority-Analysis: v=2.4 cv=BZnVE7t2 c=1 sm=1 tr=0 ts=6967b690 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KvQaFmux51imLjMCrhIA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: aUXGrIbTIfhSmpby2cKOGe-52XZaLPBP
X-Proofpoint-GUID: aUXGrIbTIfhSmpby2cKOGe-52XZaLPBP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140130

Remove unused includes (no mutexes, string functions, no OF functions)
and bring directly used mod_devicetable.h (previously pulled via of.h).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 4 +---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 3 +--
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 5 +----
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index cb295856dda1..f9d8fb1ab1ec 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -6,14 +6,12 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
-#include <linux/string.h>
 #include <linux/types.h>
 
 #include "../core.h"
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 792089628362..9934ef6205d6 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -7,14 +7,13 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
-#include <linux/mutex.h>
+#include <linux/mod_devicetable.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinconf-generic.h>
-#include <linux/string.h>
 #include <linux/types.h>
 
 #include "../core.h"
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
index b0c7e4f6df9c..8cf61aab81b1 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c
@@ -4,13 +4,10 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/mfd/syscon.h>
-#include <linux/mutex.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/string.h>
 #include <linux/types.h>
 
 #include "../core.h"

-- 
2.51.0


