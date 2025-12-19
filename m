Return-Path: <linux-aspeed+bounces-3161-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB33E6689E
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFHt5Sn6z2yFb;
	Sat, 20 Dec 2025 17:44:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766154961;
	cv=none; b=FMr8+qCwQiNE5VCjsiKETVTtdmfUegFamfkzxQP9LvCDWWTrMoQ/fUbiTaO1+o/u/ixceK6uGCFMrZ2wXCljSsDg8k/18oetgYQCrLQjxObJlTm5dp/OnFPZwmHD4ECDRfhnnDxde2SYbUAOsLzEOYC9qsgwzd1OxDPyuA8Xpkl9MeOaOwwyM64CfdfPvqN76hBFOFkXgUR0EeBf3fLoWhQmkfOQ669jn4Ukn4WR3RYNm/AGwCxFTPyJAk7zguHeCaOhBm3nHejT+ernDzyHBI8aBqknJq7HBe7C+MgtKD7afLg/90ugzpmdmFYI+29zTxExy/Z5mEcafc3f52vVbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766154961; c=relaxed/relaxed;
	bh=bdVHcop5XYNpYgY2yr+3FkdwW8jh3IpYWt3xSgH8iKA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QWOCTV4N5TYWDZBR9quRX/Dk9ryhzNFNpaOM3xOEaUNdAYAPq4hKhU8kJRWN7SZvIFNpUevd1KkCKCJlCjs8xO4VTf8VuuCxaBXZAntlCvCQRDQHMGcRd8shj96soROCRZWKH/BkjO9ubyfsFqVmyrtMOev4sQg9dswtquJzWTX6VnjgzzjTTvqCKVCpz2dp44lepynlT12gSkdR+Siq9AQV87Q84AIe17KpzQa2fOcVgNvE8n+PwqREIlXFCjGIwvVDqShRYmqYK/Xp4i0rnhYTfZdseJkGOoljVKEpC4UDjRDDl5QXuqAqcHGud5/noRu3TlKkULfyFPoVbR/KFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H8MbEeMc; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hN1LWmnL; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H8MbEeMc;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hN1LWmnL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXqpR6V3Sz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 01:35:58 +1100 (AEDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJBlhqo3991947
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bdVHcop5XYNpYgY2yr+3Fk
	dwW8jh3IpYWt3xSgH8iKA=; b=H8MbEeMcDR3OAyNCv7ZbaT2jGgjxnspKFvfma+
	vScLZ9gcIKUB6mzGCGSe+SxrLuEEDnIbhO1DoJYyP7+dNsiltp4LXZv/n9omciUp
	pypqg41B//O4+bkm7RqZbiq86vn0gkxpau8mlREVwrUfL9IDtwx2A4oFyE7L43Im
	JlMVs3ZcmKnE8+hCLCoWOBwuMHZ0MQWhQ37xONF7dIS6FmijR3ekq0KhWEB3zyoi
	UIe94lKxvqPbtGJDSj8vKtJBOSVbxN6fow7n9s1gDjJt2X4sul/5TfpErnoUeCwP
	tJrAxrFfXlH1yNXXRiCjiyRZcIQB/eWgFOKuxJHxPpCZ8NnA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b4r2daw0s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 14:35:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f1d2aa793fso41307981cf.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 06:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766154955; x=1766759755; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bdVHcop5XYNpYgY2yr+3FkdwW8jh3IpYWt3xSgH8iKA=;
        b=hN1LWmnL/wqD2J7aeF4ary0PgvCxXrqpwSvO6xeAoBCmZvjZiB/f7kZkAxiFuxJ55x
         s/HR8tY+KDppJoQ25/O1Emm1k/O+Tbkt0fV/B1C5hNl287zssN3997iOkhoj+LGyEzns
         NhlG67f9RQv3724m09SkrnscdZvEjBfUG7bgP7GAsxJHy0lFDpPfleSkTtvcPrDn3Vhn
         3PzhsdIiA9sr5OiMa/48EtPMLFbf5Vu8rvZog55wIqCzotwKUQQmTXvor7Agt0iPYbqH
         elkbC2oVe/ezDFIcYW2s1z7/UVdoJi/3wJ019TykPjNlZ+BK8H40i5oVLZypfKtnI6N0
         DWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766154955; x=1766759755;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdVHcop5XYNpYgY2yr+3FkdwW8jh3IpYWt3xSgH8iKA=;
        b=n8m9dm+6Xh85vSybDo8dBIWSLNn1+RRT2I9hUhybjYVGo11tVjqgUzquXyfLD5qy9H
         VAkfECjpVcf8bfuiKVEPwAyKIAxvGjO+0gJfBN0lcQNvID8yT/HrTWcL538Jkeek8Wlw
         TkS15HXGwPxIyPNE/HDiGJKH5KkgqQg/rwYeQDQlDB3Z425k9U+jKqTOrXRSZ7AdAno1
         IZP+QwdyrHo2QNfUUYN2kFE7dpvvQy2875xUwQCmhbK3LsvijgX5Z+vgWeQLMD8cwA6i
         iPGgCd7OCkyUj0wYuE/ZbxWxDxcOvO2kL7iz+uAQ1GQ+Kc39LYv24BA5aft1uuQADLgQ
         N8ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlDhUKLi113Mx+tQ+NC1ryfP7wC1Z5hYLrU7xuQSXU+OPG5NTL150upU3d1K32JPc/aTDiYwivXyMo9uY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx7RsOLd36Kq9PAjROtJIQL5nwM5z61LNxVs0lb0NPXVDX9ygMC
	0KWVrXcyDiNobgTVHJ8ra8c/dlUrmmNM/IH7RgiSoYhDkqsGV92rLOb+ZCCE2OYtjGIVLF/v1Mh
	WpJDa6fgfLb34bL8BTT5MsVd9dZ8lj/Qv/74fTwPfl94gf6AU6t3c26FfxtSG952vt0eO
X-Gm-Gg: AY/fxX4+Vzn99XFg5e0PTUwhe2bg7kI+fpUyiKic/3ADLPK8rOqWnz9Hk/tT7GDqFON
	/KIYsYCFTp7yg/vpIIhFT5M8ha6b/jCkDUAL4VA8b0/jOnpSv2CCBUaoFpByzrpXKobkrF8KBAy
	8+obvJjStCrIeNIBByenCKAhXJ6PerLB07x9lIhUpSY+P5rAuFuxtUAznX21cG8MPl9kuanQj1z
	VawX7CtbgJchjKFDYTAZfIdoDX6xoUvCENzUnieYvZFPVSs3VEyVxeZmBr9x8dXnh7oF0D9oiFg
	s7yaMeM1AFMcZouoe5gOO5FqVQLECvebppWQWwd+mnLCNY10ITRA45jgjTehwV3c0SxItCK75px
	mFCPk86zfMzr08F2MPlt6rzTtpug4VmfA8ePO6ctEDEWtjnw1NCFewHs4PwcGwyBQUa0d
X-Received: by 2002:ac8:5d08:0:b0:4ed:ba76:a008 with SMTP id d75a77b69052e-4f4abdb4c88mr38663061cf.73.1766154955531;
        Fri, 19 Dec 2025 06:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEffbFxw8X7dSObyQoz5slOTM2CgBwKcXa5e7U5F4RvPeNF54VvXGRIgsWbtWtrOWj00iptUQ==
X-Received: by 2002:ac8:5d08:0:b0:4ed:ba76:a008 with SMTP id d75a77b69052e-4f4abdb4c88mr38662351cf.73.1766154954913;
        Fri, 19 Dec 2025 06:35:54 -0800 (PST)
Received: from [127.0.1.1] (83.31.98.88.ipv4.supernova.orange.pl. [83.31.98.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f86sm245145966b.17.2025.12.19.06.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 06:35:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/5] iio: adc: Simplify with dev_err_probe
Date: Fri, 19 Dec 2025 15:31:49 +0100
Message-Id: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIANVhRWkC/x3MQQqAIBBA0avErBtQU6iuEi0yp5pNyggShHdPW
 r7F/y9kEqYMc/eCUOHM8W7QfQf7td0nIYdmMMo4bfSEzBEDFSQRTBI9oZv8oJXdx2A9tC4JHfz
 8z2Wt9QO2tb1AYwAAAA==
X-Change-ID: 20251219-iio-dev-err-probe-59b3104c8d4b
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yDoEuSqPknkwVP0vazPsHzAq74kjVOByu3+rGhvA4Fg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpRWLDVzK3BklVItpqweq/1miLacOG2Cpj1HQRt
 qYMIHAS116JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaUViwwAKCRDBN2bmhouD
 1472EACOzRsssmSeIC4dDsW9cdUyuX/1DfAEF31eNrw1wC0pyBMfIWJNnL2LSlQaWhLMVwkDaRx
 Q6qs5PZ+m5HSWN0c9B1IYnCaBdkg9i1tYfZx91zD3cFo8C3sFJ4cHai7H7f0h5OmhvOyZ8FxR0l
 al06ryQgbWCkyk9k/tWLHL+q2IAlhtfGuCtZ0+fD5kpkZLoVtbbKrTKNwlVTaY+cXWQF4BIIyDV
 AMV/sIPce94hEHphyKJlCqioXya+WMGdqumincCRkLKMIeFBE/peXUw5dYNkajIMJM6xU8axA9R
 lR5qS6Vd9zzuiKbtXRwkUBxu6Iv1eQsH449ypPIU4urZxHPbWefEF8x+KFqIL8jM9LWWev1CAwJ
 uVo9yYZ46EPZiYJe+xWkunZymrftSRkCkihcfalicTpVtRcgFWH13sIFqP9XK+0nlXJ4AXngRjp
 4hS92gmbRS6+yzCsyH9TqRxujuDbowBSxua62u0DdBeX3T47ruoQmDUCcaEPA/SKd3HLoYtpSCU
 SGunXOmPp04MuDM//S4PdHiyTXk7EzNoF6JXSrC7AjaZoEuWbadPnfJGv0EEIJLHvzKkLDByrgB
 RtS/oL0QhQ6zURKrKaZrsnxmBVjr09C/uqHNhnmkj7XmZNMFWZ7b1G8b5QH0AjIGARciWoIiza4
 zNl2KZibzhmH4ZA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=AcG83nXG c=1 sm=1 tr=0 ts=694562cc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=qe4J/qXhiWkb1JZGYKbLYA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pGHnGGPHKRB7WeD4iHgA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDEyMiBTYWx0ZWRfXzK8PjqielMZc
 m6lcMBzYpdWHkPp73qmCHFGQfBRyio/3bJRguQHCbFMIf/ERkEXb2/BYX9KUz9hUrbZqoi8IfSs
 GXD5lRIg8zOBoZu1Byak+rehAhiw3tbEK6EHpIdKQQNR9tP1wLZUin1rOY1W/vuTGE/5tOKO8uC
 9lAw9iZCycSzomNm6JtQd3L55rrmQiOvhp9W+6soitGhaEaymJjKhBg8nx3ZEnAWIErWLhva77f
 Q/ePLdHtpkfZdemBoLHlZfGMrxllsiyGZpUm2aYZThfoppXAqklJEgBircdUkBSh4RqBxscYcuX
 O2bOT/rTMKCDFL8/H9afg+JZJMdYrJ4Q7BjPw1JlMCKX2Aa4SDjVk9wSlXGv/h3mtIaudLVtE0M
 bl1gMA4K1NCYSMA6Ul6tPARZkjJdk/dDzSASRGe7lXr9E0lk18tUNC+PVBeycR1nLCAdSXoYrlE
 MWhBIFDMYls0bAHMjiA==
X-Proofpoint-GUID: tMCt8jZGr7RJ8cm6IlbX36ZmrtmAwymw
X-Proofpoint-ORIG-GUID: tMCt8jZGr7RJ8cm6IlbX36ZmrtmAwymw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512190122

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      iio: adc: aspeed: Simplify with dev_err_probe
      iio: adc: exynos: Simplify with dev_err_probe
      iio: adc: qcom-spmi-rradc: Simplify with dev_err_probe
      iio: adc: rockchip: Simplify with dev_err_probe
      iio: adc: sc27xx: Simplify with dev_err_probe

 drivers/iio/adc/aspeed_adc.c      |  9 ++++---
 drivers/iio/adc/exynos_adc.c      | 29 ++++++++---------------
 drivers/iio/adc/qcom-spmi-rradc.c | 20 ++++++----------
 drivers/iio/adc/rockchip_saradc.c | 13 ++++-------
 drivers/iio/adc/sc27xx_adc.c      | 49 ++++++++++++++-------------------------
 5 files changed, 43 insertions(+), 77 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251219-iio-dev-err-probe-59b3104c8d4b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


