Return-Path: <linux-aspeed+bounces-3321-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D38D3CC86
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:24:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds0zQ2VT4z2xqG;
	Thu, 15 Jan 2026 09:24:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404629;
	cv=none; b=oceSI5NZTBFPuAw8ZiwTQ7jpbJiCmZRC+I7z55fQ05/gmju1M9IQG8vWtXKHtO4ajdcvm0CVcb9FWo04kUGggslTzPjrbY1lFhda3O7SP+t5QKqy1h0fdrPnuvn8eX2doF3rfsnf1P31U6jHZXdpttuautu8coTjuIlRHwauwn5j7B4yRYegOwHQ9hGmD4JmWTL5xzok1haZCD8i91wm1yomod45gkmfVP3Rq/aLjpzBkEKd8FOLZjRKLXWRUrGfG7/LS/UoxaZQeGGxTdcyabXOLS8TSONdpNwEATd/8SM+MmYfVvYBf7NTz+gqdapYwSm8waeUuLxFB/fHSz+TRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404629; c=relaxed/relaxed;
	bh=TQOWmZ4i8qr9JpAuK61Y9RoWdOmJcEUPWfdU+wHADeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hSbOxN2KujgXCH6jheZRDmWCFKCQTT+WzUxnZCd7Yok+ngUBlcsOoVyXZjEIAAAJStAurFsc7kAzQBwspOMhR2b5D8TXd0XfUk+GgjnfshQdMzJmAlAzkAnSQVjvYAIs+mAHXlmjV5ZHvl5UZ4ZSLEQBe1tJERr6DgOfS+eV7xn1AOykJ5S/rXTEK0H9jHhOf9Apg8mpnwxyfDyu/nDXmm7lKFDw2f4PCpNK/6STYz0hJPWYOUvQDj7LgLb0ABiULSFGKcdHQ75ubw1sWFxJoaVDX7JKGFQwy0PoYzeIsqbV1/XGHi0hQuOEUX/kltGKKOyB4H31V5CX5G9ig2aaeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nd+c0nG/; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V8cqkF0a; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nd+c0nG/;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V8cqkF0a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnK1FxGz2xYk
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:29 +1100 (AEDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EDiIG52082120
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TQOWmZ4i8qr9JpAuK61Y9RoWdOmJcEUPWfdU+wHADeY=; b=Nd+c0nG/FDs7XoIV
	szExDaUVSYkyrbiaHalQ7Ap9+Ae6UJ/LuHmENsYmw2Y917XAkpOSA5PDn/ucsIXw
	RLjTwBfwp+vw9JlBmnZtHYYPA+nuxAqdd1pB4mQdMxi8gLqJiqMqFue9dtxzWhhw
	z2Mh4kP3YONo/VwuqMbCWqIdg2ZulAZiBjr4/v+VsHOzRPeea0BMSLLBuepXEfaK
	4TcnFo8VnR36XVqUEY+VzZlVDB5GSRQreJSVMoii0SAdOXRljAxbNb1718WPAMnT
	H1EH+vCGRqzwWc6iLgCOM8ppr/Cv0FkS9cCCOv2YBPPewR6rimIDRchIvZsKHfwn
	UwREZQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bnu58uyx7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:27 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8bb9f029f31so2434643785a.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404626; x=1769009426; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TQOWmZ4i8qr9JpAuK61Y9RoWdOmJcEUPWfdU+wHADeY=;
        b=V8cqkF0aUvZ3rLJkEDWyizoXu4BDUOGbnxVYx5aQpRwQZXZEt7rCuGpEKGfv5LacM+
         YRi6B1/cqiV7kkBMxk6dgQ8j9UwQDMWc2IoFKjkmyECykVAM7EcG9mIKahLOYJAtZq4p
         NtEELVxAdboNt6zyCt/b8aw1mS0XKGE50VlF8TLxxVPjB+VZ/x9U86V5llGskRasNfub
         j3fStP2Zz0ZfL33hzWPWxv4ewdAnty8U+rxQZSC6d4jugmjK1tkIpTl/my0/32jK0LM+
         q3TcYBHbjsI85AVehEiZWx2wX87WbvN+J9I4CEFLY+28NyhwCYWWysZsyX7I5enK5mf1
         qeyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404626; x=1769009426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TQOWmZ4i8qr9JpAuK61Y9RoWdOmJcEUPWfdU+wHADeY=;
        b=szx2G6sXOMFhvoszG8AISRUjb2xn+QcwPipJvTtGftP+nUGJbOTrvNumVg2q3Fk6Zc
         t9t7uyucfDNiefdCQM7f1LNDfUycTYChygui+N+2s3eWGyYut3g6Pvw4pgmY88kSDkuE
         qZi0IcFAcJzrLD6Kl1jmZZq6IqBBs2gzMnOk3YGO74gV73czDk3qJMCSyD8EOONg9ESq
         nnP2kteSdeRR2EbOAfSLkZ+0dOVG8YBGif7FDi9Nl9FvolIWN/cZBbZSMgC5pTYJbxqg
         3X/omoE/OfIMbLTrOZ1M7oScPlAxpCoHfXv0HB/SckM4krjokk0CR4QjzvBcdiJw7S9L
         lt1g==
X-Gm-Message-State: AOJu0Yw9FSywS4jJxOt5y+CLt55bHTs+i2ej+v8h9zP7Q4Bsj40bpiUM
	91zJmWQ2DVCRaeRQdKvZS+FVw8EqYG42hZ06FIaNGNylQXNstY62QuERsaLMwAOo+NiaX4RUaLt
	HJHFHA8qg9bxDtwdMRdAPc8D380HS1BWGvAxPfZxr8PFoiDzb8CUFN7EYBjn+Xh1eWM44
X-Gm-Gg: AY/fxX6zoNFPWm0IqqIDjtfE6+qusgWtdapRz/ldl9mAEo9x6YYDMP45FAP7XsWchQm
	x6XNBYICQzjxJ/jq+ERbFozaG0q8G49cXMqp5lkTxcMHCJW10ee4ayFJ5Wbcdu72WoLXmvhv9Dj
	d+OLNjrkg5mwmPhX5hWpTSIthPVDlHg3IZW07jvqJ/T2XpV7RLjXvH4r9aObFrvJVnEMPQJhDav
	pxB0a+Z4O+MseNSZQ3OYC3utt2v4qtEN0WCb3k9tS9zOeDGK38fuoyV7nu0zHsvKwMDJyEjqzVp
	6ropayTuOLrdOl0ssb1f3iw4p9LL7kt3HPge0Q003fwG9lLQ7LUk/r4oUFL+UUvon7uFcM/zoFZ
	J4/JvfmhkFyFfIsoIR9Atu82ZtbCZXW1CrQ==
X-Received: by 2002:a05:620a:44c4:b0:8ba:5255:107 with SMTP id af79cd13be357-8c52fb2406emr386807685a.18.1768404625751;
        Wed, 14 Jan 2026 07:30:25 -0800 (PST)
X-Received: by 2002:a05:620a:44c4:b0:8ba:5255:107 with SMTP id af79cd13be357-8c52fb2406emr386788385a.18.1768404624120;
        Wed, 14 Jan 2026 07:30:24 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:03 +0100
Subject: [PATCH 02/11] pinctrl: starfive: jh7110-sys: Cleanup header
 includes
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
Message-Id: <20260114-pinctrl-cleanup-guard-v1-2-a14572685cd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=906;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vQTc4Cx1cuzPah8LLXL26kybe/0nRvPEYAbDNlVXaL0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aBbIM2DWPBQNuBnGlAmRqfublmk+ABnSOCP
 +eX7CJ/kqCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2gQAKCRDBN2bmhouD
 13B7D/9HNpUgwKflmRiVEQKiqAHJlihytGsm6xhqvuPk0OXM6g4wK8KWJ7AoXqklkhVGJfLYvjS
 EVoKICEkLULEFDlMFEFKdNqN/uGc1TUwNp5gMcRJRrlIE+ZYvRo4LIknCsvHV1jT9i+Y2L23c3p
 +uDVB8dH2uwJv3IuhJUnA1gGMQM4xpw4ac7NB+UCOk2LnfcACtKncHKQ7jr4vbc3O0f3pfTQpJp
 dZkWVtWxp4BQm+5d1XuZwVzvgj4b/xAJcvhU0BzFKw41RORAakfzsVxAkTHHtP62LHFxnKZSwKi
 E8XvqOwq5O+74OFdv+vHFLcG/6f+rPsNDMLHCxupzCLkx6Pwqg6qJp9qYbsQJCEuj1EJyrotryy
 ANOtROt7QabL1HCVBOeWE7/I1c/PzdUslygkZyhowuMmtTrgMAsawR3fzOXHuQOQhjeKsN9lt/M
 fx0zuszc+shjokj+huAOTlufmrLlWzFxqM4Hu67hEma3ScG2iv485ncOEg87MQQpuFfjrtb+vDK
 ICaUVJAoHNSRifaTDmw6lMDG1ZAAU7vvujZpio8eHVdgOh3jPCnAMmeTePFgqI8N3JIJ+bkQyuz
 2wHidhJCNQckjPlFZ10HKxqor1PXsDvliPHX6i68yW1W61YZ+wIbn5bOmZ0GIDO6/jOlooNoy63
 tkrtX+1GbUIJE4Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMCBTYWx0ZWRfXw7R+OoZVWRRt
 Md9XWv2iBAQyDGjkv6IcxGZTTLOs52rmyl1JO1wX9IbPBwWLB8GOcos894bPiKHstoIBVjUw2lG
 PMkRvkFOJmAAeyIWFatxzslPnOZUFPUzEX7dymCUrUFIhM600cslELKgR/OAWhtrVvrz9CRrrXV
 Hb6i3MO1gAiX+l1nTlcwPDkeDeT6/9ioaqM4E4Lbu3rHPZfsWFT7ns8N2XOeQDzEw2WPlV+gVl8
 0hGISLElhVESpET8XNHaePan3o+LC54+mC5ARtjfdFklYoeLrXkrzIF6j3ALOEIrnF7nXf5k8OP
 LXjQWXM5D6Xj1D3/NGFRQ0CDcMK8uYYQs0XiUIIzhTWuD+C0x77rHiSbqGsZKmV4UsSyVcSPZd6
 kSoWZ3RcMb13z6qMHO2/N1S7lFD5RCtOiANhMbPHz+zt2g2T66J2xZTkr3wYM/BqYtb9tIU0etY
 /js6fqocgI6JMK4pFaA==
X-Authority-Analysis: v=2.4 cv=BZnVE7t2 c=1 sm=1 tr=0 ts=6967b693 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=b-TtO4hhcUHcL_E8iecA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: lNc6by1do9cRfR7yI9ocbPVFlYybfOVz
X-Proofpoint-GUID: lNc6by1do9cRfR7yI9ocbPVFlYybfOVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140130

Remove unused includes: no clocks, mutexes and resets.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
index 9b67063a0b0b..44f84e4c29bf 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110-sys.c
@@ -7,14 +7,11 @@
  */
 
 #include <linux/bits.h>
-#include <linux/clk.h>
 #include <linux/gpio/driver.h>
 #include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/platform_device.h>
-#include <linux/reset.h>
 #include <linux/spinlock.h>
 
 #include <linux/pinctrl/pinctrl.h>

-- 
2.51.0


