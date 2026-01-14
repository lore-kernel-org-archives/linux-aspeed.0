Return-Path: <linux-aspeed+bounces-3324-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274D8D3CC84
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Jan 2026 22:31:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ds16k4JP2z2xrL;
	Thu, 15 Jan 2026 09:31:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768404631;
	cv=none; b=UP5d/CLK4IgoNl76WlXxSrsJVT47GhMMSwHczy6hUtRB1XRS8xqYA2HHHpR7xI91hMJ1QJibD//bUuHTULuqTqwzx2Mhr6n7ZvRNUr8lW0KWeRDxBLhWY/0KIOIY+3HQzqv80ch5hzJvtgg0WH4AxpgzVpwdLKRH7VRtCk4vf31qZ/HfAzEMbptoYooR7T97FG3/+84thRv49DZZfm/M1Rz62Zwp0BXJYyfXcjsS17BHAVj2JeOsZlfa3V3mE+sCXR0llgBhytU9jVi/63yA7yW98RFJthii896swoCkXjhz/aKTTid3w95up9SVj+4Ep4pN2hoazijxy6aKGXeZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768404631; c=relaxed/relaxed;
	bh=Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmXAKBAtZwQeefyUqf5Nns747lKxKj3eSn+sg1Sak2N77opUZGf9hP3Mj7C9gx35Of01KOOCAAkwKKXlrbgfVN2MdFrvk8XSoCCu3UyUl3QbunHZrVs0Bj+C3K6hVcksKs6JxtuZxzgaf1mmebeigl1Rsb/EDkhdg5niRfDLdmFpcQclowVO2ZHvgA30cmY+r/1PZ1yRH5RER0DRp8fO306/EV4MrUrMY4n0m5kqWqEcLSSDGiKuCYF6RC5wQZ5gxKfoDjiIvMyqcCwPvflmJn32VCurt+7/Y9MWa70jGQ07MBmx5t0GIYin/3hIkLKHp7sm4IAlAEj3fdxdGnjzxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ja6yf+55; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Du97iaHw; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ja6yf+55;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Du97iaHw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4drqnM1rQwz309N
	for <linux-aspeed@lists.ozlabs.org>; Thu, 15 Jan 2026 02:30:30 +1100 (AEDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E9k5Vb3296690
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=; b=Ja6yf+55fHq9cr9+
	3BmQxbt5bpN7SHtBWVenCY2tSp/rN7yEiuQCqdkiBXi67+06a/9pLEqUAeXLTdNc
	a1grs8LrblCreo1vw7SXp2xl5M9w4EIMROi0sTqscq5x2HqimEYP+t9LG7NSfIN0
	oW0mJSmKZfsrffOl10LCS9I+c68oIPg6PMdbu9NWlAbfYeIljtZ5LwgkSSYHwo0I
	3JOnKWXYOoVsAlspcsRJg5tELpY5u/wJniUo+jZfwG6wj8mYx63YcXGrOMDwboK7
	SOhO1+6gPKgS8ghvVXEQWk1ZVwZqbf1Hap0Q/5oJrgreJR5QtLCL1pFJaKpiTSIP
	2G8J/Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8t2s5py-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 15:30:28 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-890587d4e87so221011036d6.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Jan 2026 07:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768404628; x=1769009428; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=;
        b=Du97iaHwAUUkXPbJ/q/W8woHuE40mjzL5lz67VYp3qK7gqGHjovjB8RltACKQL/xCS
         B9Vq4yAJQFo4pXbApSCRWgX8DCWr/4N1yXNiACzJD+mZcOnfl+Xo4Wa5UkB7p+dQEaNO
         t+2HySRLTroP0xvxjr9fjr/vy7nthFcSgaUZqmLRm0fhLgPICu/ehmPo2WddBgsDJvAe
         JOMdrrL+vCxGOiL/fVzU5muMsKKGsBEoWlf/C4IXmf/C/gA+sMNoJVX3tDL7vp8AN5R/
         yS3/X6V9simbKS3A85wLlLjNrjrjJCp10RP+Y2qOdgxnQnKuXkf/C2vatMzLNqsfXpV2
         trzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768404628; x=1769009428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mv0nQD2Fz+xmN887PWY6S7g+L/xnSZWABnal0geai9Y=;
        b=QnPFSVoT76xv+2D9vTG5lBWLYCbEPfZj/B0IwRuPoTemxSN1NWwWflMonMS+rBsj8q
         XkgVKhZtA8lIZISs7EE8MEZDFbvjeeiSSNHSd3mnxVgs09Ql7tZIvj7qBqLONETLL1nM
         Qm3mfAPDWIwCAmLkogRSSC1tzrq0ZQ0nB18VqqF99T0PrwFNG9Eif9fi95dIg57FwyQu
         5pBqUnj4wyJ/tq4RO2vPXcKkH5p1dlp98evSZ1R6dKUWMTsYpnlVraxcg+PNJrUtRMlK
         XipvzZHtZnoiUgeLkKCAsqfS6cc8x9jYIJsCX7Vb0vDnCafcDg3OkWes/5iXP9bFrZe2
         iXVQ==
X-Gm-Message-State: AOJu0YwjUYGpL/2QLnwt3hAerI+pzU3ssxa8lTQylw6oQ2ua5GLKPkG+
	dBz0ncxdxhTIH9qSTwZpSvB1nRr21V5+AaV+k8RaybULdaSgS5RIY9RkolBzng6RMYvWDbtI9S2
	L/dHaI8KCeVyqWNsPRDlQVYbfYCEk2gmOdmCN5A/r7VQWESS+91+Fxd9+z7SMjs4FPetT
X-Gm-Gg: AY/fxX4+E13UgsSoel69ojDglrE6SJ0Jb/BvqGB9vEAAcr2nGSGCsDbeAM1MOgJghqc
	B9fRdSFEhRdo/i/1AyIfQ32Z48e3CuKReTHm7kaHjarLDK2gLyBvE5H9J5tcCRnKZ345vueOWMI
	X1yHZG0aq+TM8pnZnZpIfM1RbEyOUKrR8dwdzn6StOizJDWqEAwjejVGxHNmWBubcPLGs0cT13u
	eUFn2VUJyve7jiudFc7awuPapTaJYEZCqYObkbScV2dAQNfhL1w4nUDFSBI0rQHwX0z9Js21oZ5
	Y3IZvXAq4DLvHkU8+6IIJ+UjXNo7sO9HbAIOYfyDsB1p0k+v8cRKRENLnhDMRKpsLQHqhq+nQMw
	E0iDND1DHiCaDRZcKzIDA7Y0smj4k7TvoFA==
X-Received: by 2002:a05:620a:4443:b0:8c5:2dbc:6244 with SMTP id af79cd13be357-8c52fbcf013mr422896485a.47.1768404628269;
        Wed, 14 Jan 2026 07:30:28 -0800 (PST)
X-Received: by 2002:a05:620a:4443:b0:8c5:2dbc:6244 with SMTP id af79cd13be357-8c52fbcf013mr422891285a.47.1768404627841;
        Wed, 14 Jan 2026 07:30:27 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf667fcsm22812989a12.29.2026.01.14.07.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 07:30:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 16:30:05 +0100
Subject: [PATCH 04/11] pinctrl: amd: Cleanup header includes
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
Message-Id: <20260114-pinctrl-cleanup-guard-v1-4-a14572685cd3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=775;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=KS2A41254/IzptP8+yKUiwH8wnfKT/gY+cirH/V2Wao=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpZ7aDV+noj7ZcYLzGFw85urth6DKCl65+zERGB
 6whzCjLMW2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaWe2gwAKCRDBN2bmhouD
 13ELD/9w2SYmYalYA5vFc6Rf1PTVYZ4B1dYRonz1b2DQNyOu2VbPve8mcP3qP5S8Lunlmu9pnM9
 XxA6ShVzZzR8X9u1+aHI18FkeFftaZO1X/ipHiRgWYmwxHee50F43GoRYkUKtL5EeGs+pgVFtvS
 N35v5ZOaS4dRcJ97oRggrrqF3+rewugdNfcOjABy9z+5McTb/al3fNFk7obz1H3xjL77Jo3RQcb
 jKwvKaJYn+puhraiSHisoI1Q8H0GnWywr6Yq12zvOzY10VAU828u15UF1rvvfdSZBMNoDaZN8YR
 MY/C4aYFC0Y84PtJu62kmJ4n4v4JBd/PrIYVnOSEvIoAZkqMo4it79WoNtuEoNx+OhSQ0P0+FTw
 ncPMJVQ0RwPTjUhmgU+Siqc1uuFokQOIgc8sWxA187rXXifisB8e0Qz8cofr4vT2YdFLTDQlTtb
 DsVJhtQvL20afD8ktEE3e9SBn/kC2U5XBha9yUQiLszF7/SkefUvWkoLphBJoHJQesPlcSGwLES
 8ZjODkLNTik+YIzT+y6r9oBPDa+Ft1z/sPRZtZpjZCeGeSqLeOkBl2iH5kgzmgSjGANsVseb/1k
 xn+gb1RtR8rDo4/67L+lt6mr4ki4euFWZMFfg8c6VM8c7ZQonmBPCX9sGdbGnfFG3z8Loh8tgWe
 NlXvgC6SiJVTR6A==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=6967b694 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=tMXyHTyi87mTYQFNLaMA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEzMCBTYWx0ZWRfXz3Q9AdVwuvQt
 Wctq+RRcZ3KvLZIiq2ooX0wtW/OgfTCmM0dKpMhMKOcdyRLcppcL1+dyuJYhbc/DcBeqJ4xqLhM
 jwkJXDWUk8CO959X2h5DxG6Dm2fut9SdHZODMkOXFZsrLf9TSlBtKc/3O6R1PTsxz7Po75NddgL
 Vkbj4xiSXKKdoZ39zHJJElZUSZhr5rgrmZVI3eXc7iovrQmsq5CsZQ//Je4b4V+ll1CeiY3VqWf
 OuAUymKO9frM8SiHZW1y4e/usbSjM8hHarH5cUB18alRJ46JUvXcaU2sYf8IP4hhCZ9LC+vdQ44
 yUYd73H49su69MxVVzwY7rQnacJvInCfZ28Eg8XkUH0WKJzMdMjz6Rz4bS5QRRP58yadEwfBnVF
 VzUo6eyDbEz8Qs38YV0ArWATp4GxfBEdmy4csJw1e/Whyuv5r8H1AqMiShgOI7qF8c4nEikTNZ+
 93ZKag0dCCrJ2gGxjTA==
X-Proofpoint-GUID: tIrkhPRBe-96vCq5ga7bwHTXbpSdmqlV
X-Proofpoint-ORIG-GUID: tIrkhPRBe-96vCq5ga7bwHTXbpSdmqlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140130

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


