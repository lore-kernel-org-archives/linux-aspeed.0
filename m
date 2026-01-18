Return-Path: <linux-aspeed+bounces-3387-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412FFC9830C
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:22:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2f2lNMz3c40;
	Mon, 19 Jan 2026 10:21:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759811;
	cv=none; b=g/3z4lA9FX0X8q7+in9e8Qgo77JDQgLl3fFYUcAQk8E35kvLLExQlXH9y5XQbQauJNyk58EMM84IoVdae420Yzsd4ed40FZE09290+bNNdO284HF+LzDWuhhdRzvn15GDay+oygG5QqoOodeR89PMfoo+fTjEDnYwrT9FjLh6gWrGkg1xmsSBUPdTvtxif1rXUyA4xTzry4TVpAKc/b6xP2Wl2YuHXGqjBvK9Oos5gX0fN3obFJI3jYYUkKe2rrTIegIhCY30P7vdZ01WbeYrcGJF/t4yTnCOifPYMtB9FCC7QBTXW7EBHqq+9QeEA3QMRwygbNKhTSWFMaFbLu46Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759811; c=relaxed/relaxed;
	bh=xF+EKsCw3DAcisLqyjUVzy9KuncQFl/L6/ZeXlOHhAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QrAfuivdMh1s6tSuAKwymL8nCgMBDWZvU1VdH2EZ4UOp61nby8VYKCnOxqPCCUb1vnN0afrw32+Pf6XhMLTqlnv+WLx57BQnS46YHGgWKLOk1v6zrIGxH04dlYebqoS2mblyGlV8KAhaUM0OpypOEnaI2kwhM7nSSUYy851ndwbHFkAjrfFFSJeEbdllwCRNfpd1jJxNeRSzsMffmanclgTroG/xe37l6QoHn3IZaRnCml17DLblyqJPS7Ufis3OsudcKoi2si5yKyVSTqOONBifd0KWuktRqU1kTUDQMcTRVa/fmveJJolEdsZnZW3jHkNDarzXF4Udn+OwU7O6aA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eL0a1Qb7; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jur0UMTd; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eL0a1Qb7;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jur0UMTd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM7k3qFxz2yFW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:10 +1100 (AEDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60HMwEkV1013307
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xF+EKsCw3DAcisLqyjUVzy9KuncQFl/L6/ZeXlOHhAo=; b=eL0a1Qb7gDs4Ddve
	0NXzoUo9WM/0fPiz+owufJ/TN7UB1YorGCL5iME/3xC20RYpToTyzU9rMAl69/cX
	p0se3f7oX63VGOYHAj579mzRleSJhJKqA1K2iejV6rNmmjQiZuwrXiluUYJeYd43
	p05ezSi73YZu3gmMpnkbK/NT/g02StJ2p+xr68eOs+RhPvxe+nqM/+kqh171eNhf
	e1I7pgMXFtt3HuLgyHGwJnoLoHWAQ8vKfYIWwT6yLRTTp7thQtJU6gCSi8EfTM55
	bOH6F+Br1a/t/yoE7EIMymmpb2Q/8yYy+chJp1osPlgMqMctqVegdOP9YCBrenu9
	NTwUXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br2ke2ran-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a291e7faso309770585a.3
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759807; x=1769364607; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xF+EKsCw3DAcisLqyjUVzy9KuncQFl/L6/ZeXlOHhAo=;
        b=jur0UMTdHaTDN2EyzayFi4aczoNgP4C2wG9dkWNXdRRe3QjTVXEI5IRIYZj5WneVKq
         bFmR5k7ffI82Sqw2fpy0jPIHLM1uRH/IpKSiFEd+Wg9aZM0lVpYYz8HnY2XoROTUPpcF
         C5XEy5s2rBTM0RupHpZtqE4O7cvuvdCya/uC6N1vh5E9DLyWdXQacW6/oVBpaBIHagfI
         VZ/+r3NzXfnA8JldRL7LUMy+koqwhk9sKBRMS9dOYkoCcBIAxuAn0oiP0mX8PBpzc40V
         qc3IatDoxvvY3CEO4aJfXB1hkznqFPBzTkoQxeC6Vxw0jpkSEswBMV4r9w2qddrjg3cc
         mKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759807; x=1769364607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xF+EKsCw3DAcisLqyjUVzy9KuncQFl/L6/ZeXlOHhAo=;
        b=Z1cAXZhnDT//+GjqrOGavvfU+kGscfzOg8h4j2JH9WcaFrfXgrE3YvdIB3H/NbDnP8
         3qUDe14KJ8OmZNF8E511JnqDw3LcPDfT+CdBp3Ss7xtdpDgKdK03Ei9T0ZwFUu0AHCWX
         LXf4ErSUFIlaXWpYdu1C5Ng+qZ5+8WoGhel18vOgEJi/XJpib//Ea3zL5LO3DS8DqbTT
         HfnqmZw3IdD/kbXMzl5lL1uEmypxz/Lxr8hhvk/yxGNg1dr4EdOPG8Ku54Dy/TE/w81h
         5MVTM8RaQGjSWEoF++YwTXfnuxNIGS5GMPeXbT92AaorphyoDgGREq3yZrYEf1yD1PVl
         hSxw==
X-Gm-Message-State: AOJu0Yx1fS47X2QVtY9OlIYmLwTC8UEVX3azRt2mqo+nglsHYYmU3YzI
	TYlCfW8/TOnbgYjk76yMTe+by2TzH2rp9/bjWGXpWk+oRV1Rr8pbJdeCOCr9I8HDZeZECMJzc5D
	2PwnkEFP6DOhAKy2eT4hb5TkJT5gumT6Fp2T0mNo1eJwQlGe8wa1r8NFnGeX9HAi7CGf3
X-Gm-Gg: AY/fxX4WEf7BQuv5aQ24JGqy1UxptWR0mOpwuYfI3ReD6J1V3kVnYBefR37T6v7o4JI
	UZLnlUrPyAVadEMI6iFwZmqLwHFTFJPDDGx596nEeYrLUgiSpFByC1YyyXnu8U01QRLtYux0Eaj
	3Ajse5owe+RgV38n5H4k4YGbU2JOEcqzyFPjcyCoLCBUriZ7EW5c27uIDbE2ZAkqUssxhJ51Dkz
	e/ggeF0gLXLpa/ObUoyIOLVpMpRNtxlzZJsFEuXIAVQuGwlg4qHFj3qhv2ZGqiQxNGF1vMzJuT7
	ze3RYdspgVGaOPq6N+tp+ju0VZPxD8nlcIypfoa5NxEdPHc1or2aL5x8cbNAUdws/kDK3/saZdV
	rkAQoCOJ35IWqbtbP+ZC+LJAkW5GsGSIhJg==
X-Received: by 2002:a05:620a:319d:b0:8a1:762a:ab13 with SMTP id af79cd13be357-8c6a68ed101mr1320494485a.10.1768759807232;
        Sun, 18 Jan 2026 10:10:07 -0800 (PST)
X-Received: by 2002:a05:620a:319d:b0:8a1:762a:ab13 with SMTP id af79cd13be357-8c6a68ed101mr1320490285a.10.1768759806815;
        Sun, 18 Jan 2026 10:10:06 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Sun, 18 Jan 2026 19:09:25 +0100
Subject: [PATCH v2 02/11] pinctrl: starfive: jh7110-sys: Cleanup header
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
Message-Id: <20260118-pinctrl-cleanup-guard-v2-2-bd36f681bdc0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=957;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=7QVsX3meH/ya2n+MBwkYR1pzRXVW1X0rbx6284HAjYo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSHvR6NL3AOW754D5v84SJb7LIyFBtY8KP66G
 rat0rpoDimJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h7wAKCRDBN2bmhouD
 140hD/oDwb35yyHvtbjc/M0Lb0PMZ0C388lWdCmXu5PHWfBfqbi0pqIpiLHa/I8lydecaQng+2T
 6pXYaLCQXfyx6d6HjJ55DKT0y0CB6wGv6jNrkEel9RIEZtNF98EnmNQ16fH/1rSb9mkMC7i2p7p
 uDQZ4QUXT4LLz83NgAx9pJhb0KnfOtuSCj7ilWSVwBJAtUtjFo5I5GRJSTTEh56yE2ZABLc4cPM
 v3zF59Hm8PbD3E9MuXG9dkZ3zcW4LPXVh80oYbkUYomCkspDgpq1XUWslyrduP8BRg61ub43bFN
 D7b2pKxQcp9n4qRPG87arVBUJzO5bUdZriEhcvIwRA8g7Ty4t1XjUE2dBdcmlu1jHGR4yu0AvNS
 J7gZipSXXYh7pfrpXX5hfVYQaU0Rx5NjFvVJYlHsg3MPu58t0NRwsCZyu5njKqBnL97H23DcTnb
 OGU6INWVFiyd26HXHhgTxNPu8HbyBRFE4CXAtbLk+R38puFmLXoAIe93PD83NKVNNA5JuQ1qMDT
 03Mtb/klRnsQT786huPeUBAPeMhGoyfg8zbw5gZNhOsb7qtBjGABqQ2+kFMbdfME3WC2aEWdkol
 fQpOxqisp1hpLzun3NpNsowLGMaZelCuMxI2s0Eqx5whKM1Oq8cNrvIZKO9NQDkY4SqD/TZ+3rw
 05cWuH/pid0x7LQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE1OSBTYWx0ZWRfX/ZZJ9dgAFiJY
 tkjpPT4/F/ITUuyr8w1XcjZ3+lPGigcSiTGNEQpJhvhvrDrzh+07EQmwTYvBrGtGq9fcpROHL1S
 RcRPUqBP9dIkVvLkd1r9NwUYDDiawafQZLfEdzpVl0HsV87UK5kdGuYu0k9uFijc7h/QWUhJjoY
 Rl4tQhEluZBXAkwrJDS6NcQzesau/5NUQR01Qvj3FYAFxx1Xz1PXj0hlaquHvJWZ/8JckmTnw+T
 SuG48abPCGXdIAnm7YEjgadFKi8tjQJyK2nXJP0beS2sCKjvzIiuzGZOzIG8Z66KhGYaD2UBHBN
 p0g33NKwd0r4ZNkfFc36I15z1wjNQIvnQ62KvzYNzOEq3/qV4LuKRhdmEXyuQIy5pYDxKxCrZl7
 6V08UxXqTV8i5NTRXOxLAb+E1Zp86aiZgxUuYsiTyVwPnJk2K1OMa/vVkshNM2YrGx0S/Vlyhjg
 WrAjbHyhYkSr3w2hZZQ==
X-Proofpoint-GUID: NKi_Mmy3RjGccXomJ1pqzq9vELZZzzom
X-Authority-Analysis: v=2.4 cv=EJgLElZC c=1 sm=1 tr=0 ts=696d21ff cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Bq6zwJu1AAAA:8 a=EUspDBNiAAAA:8
 a=2Nzugx-BcEq53SDkSVIA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=KQ6X2bKhxX7Fj2iT9C4S:22
X-Proofpoint-ORIG-GUID: NKi_Mmy3RjGccXomJ1pqzq9vELZZzzom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180159

Remove unused includes: no clocks, mutexes and resets.

Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
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


