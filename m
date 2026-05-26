Return-Path: <linux-aspeed+bounces-4131-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD16CD5BD2
	for <linux-aspeed@archiver.kernel.org>; Wed, 27 May 2026 00:51:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQB025khtz2yVP;
	Wed, 27 May 2026 10:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779804543;
	cv=none; b=B5mLep5rUYZSYaC6X6Cy7Of0kUYfytPH5G3oONHFmywD8ZLdpU+V3XYiZGYI8to+fODLgroyDJXPQHgClpjaVlPUC5M6bZ9sEDUQ6SqNa+5CPWTdblsfRmt0Yk1+2J+HFo5CaJmWQYkyKDAw5u5NQPpI3JBCgdzQBnejiL1vg7pVJDPwblmuVNBZwwc20OERNs5p95eoiw7Ndm8v3Gk0HZQIuCQfrp0SVcrRXL97J/+OgiqKZJ2rjbB6wguRa418XZjIH8sOK0eS0hdyECmgW6bvRe01jB5m8yXqF3sA35OIqXmmkRxihBJD9/g2joMUdMZzek9z4QzgMFS9OSZaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779804543; c=relaxed/relaxed;
	bh=oAKZkwwe/mBpi8fxwxEneBxaGJrf1Ao9NvbMtFS0K5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJa2VjNZjBcTCettbyiRekZtPF9hE3HHTrPiFJnY8tFteaepY9/bJ3thMT+Ney5K5vtKMTvgdytxmCXkQ3bptpOaU3vA/XbK4K8rjPpQmdsztiJPnvJKfJpEa1f/Cxe/54A3M5LHto7qQxXP5Pi0Ghky056QN44ETBr66YnL/DnobE3POvNSrxHnxoWjSLrLV5WyM+wAZhPKyTWD/NCRzVwYwEMHbk0OSd6JsbQIJlD6PZMn6qaBpD/Yx79lwynzFa9ZfoG4CgiedCKodyetnAJH2ou78f2bGSWts/SkiKW/VHWAHhPVng39oRHtB+fFAgQzP3SxLbeKHc0KMB6hEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CL9NQZvX; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FM8M3AkL; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=daniel.lezcano@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CL9NQZvX;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FM8M3AkL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=daniel.lezcano@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPvkN3pW1z2y8t
	for <linux-aspeed@lists.ozlabs.org>; Wed, 27 May 2026 00:08:58 +1000 (AEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsWxK2882545
	for <linux-aspeed@lists.ozlabs.org>; Tue, 26 May 2026 14:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=oAKZkwwe/mB
	pi8fxwxEneBxaGJrf1Ao9NvbMtFS0K5Q=; b=CL9NQZvXjdyY5XS7OGoM89Y+0tf
	OgOruddA/abljxYx13r4TVyhImP2M2KnSFNDt9ZKk2Z1BswQPPHG6nTgVKBuR/1H
	7Ez5D6Jpp/MnwcTW1g2kQJsaPsS4ItExCMWfyzQtE5WYKBwu31jrbADC+wjze6Ip
	8ubANYg2Yzs3QlTBToPkr/AD+IjqJYyh7i+dWgPehsC5CqikNATq4+6UUOTtG5Wt
	KEx1WqvY1gm4SeYV3j+wltrEnXqx+Gs7w1wRpHYHIXc/odZOLZhbz90tIo+tWKmP
	4+RN9oPpj+CQU8ZwfE0K+M4GqfQo4dcPkXHP84kiXKM+TO5BT7CkM6T9iNw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqudck1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Tue, 26 May 2026 14:08:55 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6333021c63fso14971019137.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 26 May 2026 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779804535; x=1780409335; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAKZkwwe/mBpi8fxwxEneBxaGJrf1Ao9NvbMtFS0K5Q=;
        b=FM8M3AkLdg8e2tyEn6zEj7vaLVJSx2eOoIQAxaIUTOu5KjmiKEbvz8B/KiQNy6o58g
         o4NWFKnkBfne4h0Lq0EYpRGeYe1B8iQ0BE9Sg2rBMYIjyQ/SvZufENyg+XTd6qTw6+Lf
         UNrZ+dVSe+gXNuBu2S0l6q74pYz3Jh1Y+UWF/ixhG5tLGFfJKoFbg5WkHbwVI1aZRG9U
         prkfewcEEj+qsNtumii00qcuhFUAKhqjEBpdEca8HhrHyfYrBPp2BH1uXMK1NbmnrtMr
         s4pJDOsxxR0FGk9GWwPwQp5zOiVLLya0LVXd48r2Ul2NHHsxRpxv9OsLuD/XIW+TsXAa
         wuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779804535; x=1780409335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oAKZkwwe/mBpi8fxwxEneBxaGJrf1Ao9NvbMtFS0K5Q=;
        b=ctQI/LcZr9Gc2pTOb6631T0hmFoEhUJYtMx5m50QhQ6NJwlGoVqP77I0dW/f1jrIlm
         eh6nAiUaGumAVssq3nrUAamUTBbx+T9/+IKt47XstYio4048PjukI2wOU44ABb+AfwIH
         wG85NhSIg1UhzntIXQHdDbkfnUEeN1OiDsYjWvBUPydZV7V8u++Xlkzfe1ss8QquppRN
         YNKwZ3v5jQ9t0JrSvUOnaTqtvvi/Qsp3hPY/ms+PCfQ9V3e7kFvSrCDZIUwYhKVFpA0J
         uq+bEI2IzyBSTQJw3EVbn8UVunBXAxc3HK6bucz/24IAH0LMWDrsXzpXrU25TFdj/JcA
         1eIA==
X-Forwarded-Encrypted: i=1; AFNElJ9i5dPuHOXV3YQbPpP536/bLpfHiJKgiaP1pk0UoConqV2ayzbPeYDEVQSvVgc8kiBY7uZCmewoiR6i9Cs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywnqlej8eE3u2ystvTjLt5HxIre0mnSIqvCbnP5ePvrNP6voIsY
	zqDHMxRpNrxeAA4WV1oHa4fV2wIgFFwccVQFqHRxs+4nbnYqqAV9Dj76YFAf1K+JVJDJXkllrgt
	eQ2t7ktkmvg1d/heZ/wm4aub1iOSHsyrjlSOfbtbvJI/XWknP76lIyCswB/bmkyIZtQbu
X-Gm-Gg: Acq92OGIqjb2j1poTGDmz0H/PKuL82AWcssqaguUtg7injrF4ysq61Cl1QzYMr8lg7m
	SVYIeeCRavt2BojXtLBt//zhJofRASbdZvGTZMpu0Us7GIbx1TSTAhH2OndH51+gMN/Q2qREvTN
	m/OqR3F9O69nBLIQ1bKGaL63dYBKr51H8CKC37ieHCD2ditpNjgukmnkze5cXAO0ZYfOXWCwkpt
	UWSmV6OcT9Sv4+aDkxJdYf5YUaB4KrIw4Vj/0evGuqkbIQPu/6eat9TZ17EHMeoSdzv0H2EV08i
	+DGLaThETiLYjesJ/nj+cpAQaC38BWfsUffOHlfbfhiL9QGG4H7Rdaha3sRebM+FGKp/1p5bq3/
	B/qhz27pPN/kRuoTndFspim4iu5LDEy9vQWpxmxoPpTX1QWLD
X-Received: by 2002:a05:6102:390f:b0:631:4c79:b1e8 with SMTP id ada2fe7eead31-67c890229f1mr8368202137.22.1779804534938;
        Tue, 26 May 2026 07:08:54 -0700 (PDT)
X-Received: by 2002:a05:6102:390f:b0:631:4c79:b1e8 with SMTP id ada2fe7eead31-67c890229f1mr8368087137.22.1779804534302;
        Tue, 26 May 2026 07:08:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 07:08:53 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Benson Leung <bleung@chromium.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
        linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED MACHINE SUPPORT),
        openbmc@lists.ozlabs.org (moderated list:ARM/NUVOTON NPCM ARCHITECTURE),
        linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
        linux-amlogic@lists.infradead.org (open list:KHADAS MCU MFD DRIVER),
        llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT)
Subject: [PATCH v4 06/10] thermal/of: Rename the devm_thermal_of_cooling_device_register() function
Date: Tue, 26 May 2026 16:08:07 +0200
Message-ID: <20260526140802.1059293-18-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14036; i=daniel.lezcano@oss.qualcomm.com; h=from:subject; bh=0h2gAoU1ijRj2nMRG0t8ZPVkUryalG662AE9ufPJgos=; b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalNraM9tYHaYfQukOy41BntzyXp62lD/VEEK C2fmVqqZ9eJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpTQAKCRCoMiOKKk/o T3jvCACg9mha6aH7j/o9uxZy/QVXMGG9NLUEZ8OkuaPqCyTEgVpIdAzm2IEFFRGaQCLBJJ5t+rr d30owzQ11dRHPO1vR7leCY7h1HS/3GAxa9afb0cFZoGwmhDfO4DsQSXU/YH93ce+Pq1155LBsqy b3br2CdibVZ/pVDrWDU1JeoKurjRk06L8HVXrdLKgGysmOC3aCKwgqC8lTHNz4RmkEDtlkD3uhu FNNmG/JWqySCK21zoH4MZAJJFIC/rDUizl+YxAtBUkK+VZhAwFkJwzlqZpqTdQE4kLhZAZzuSDx EhUKMgYtufmFo3cidVbk4FVk8tKs8cGXiZXwEe90JPYHQDB8
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp; fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: vcd4uRdsk1FmjUV3364o58IEBq5YmhqW
X-Proofpoint-GUID: vcd4uRdsk1FmjUV3364o58IEBq5YmhqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfX+u/6p5zVT7Uh
 kKuFYtL+307JUYe9tErpsm3XZoUy0XQd/GtIxnMDwLpk9KtHs98ppJZghMDFI7R/P3poq96cwmW
 yvDLQfyi7NN35pyZCUjqGBcrsaEldEOVBhfivNV2zFxkzQujbfAIcfMJ/I/cju8odVnQ3khPkKf
 C5sopkX9yqk85/OXcf8j9oetQC4JKSCtkyOmdJqIHxvelgsDnX9/nMiVeJal7yXt50DCBJaT18v
 3BOeXWkrGwJrhJJAk9pIOcgXq94zZwiZnFJWCpW1bWkunLWzgoMECSFRRcnU7Uly62kUsfoFsq9
 x16O5j1NgVYbKCLkrYKnKfIl37vbQCF2+tdnNZreahWb141ZUqPocsQbfR62pyhDnDZYDQXGlRX
 nQCKwF15Z2+B+jq7VfWHDz3suuCq5JY/vNmOueA0Fy19Ehj6Jr9/VykiViHp+QYwrqkzsZ6+a1T
 JVw66wimt9/Pokbbbpw==
X-Authority-Analysis: v=2.4 cv=C9jZDwP+ c=1 sm=1 tr=0 ts=6a15a977 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=9QVJCMzFHTx7fD6CVgwA:9
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260121

To clarify that the function operates on child nodes, rename:

          devm_thermal_of_cooling_device_register()
	                     |
			     v
       devm_thermal_of_child_cooling_device_register()

Used the command:

     	 find . -type f -name '*.[ch]' -exec \
	 sed -i 's/devm_thermal_of_cooling_device_register/\
	 devm_thermal_of_child_cooling_device_register/g' {} \;

Did not used clang-format-diff because it does not indent correctly
and checkpatch complained. Manually reindented to make checkpatch
happy

This prepares for upcoming support of cooling devices identified by
an ID rather than device tree child nodes.

No functional change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/hwmon/amc6821.c                  |  2 +-
 drivers/hwmon/aspeed-pwm-tacho.c         |  5 +++--
 drivers/hwmon/emc2305.c                  |  6 +++---
 drivers/hwmon/gpio-fan.c                 |  6 ++++--
 drivers/hwmon/max6650.c                  |  6 +++---
 drivers/hwmon/npcm750-pwm-fan.c          |  6 ++++--
 drivers/hwmon/pwm-fan.c                  |  5 +++--
 drivers/hwmon/qnap-mcu-hwmon.c           |  6 +++---
 drivers/hwmon/tc654.c                    |  5 +++--
 drivers/memory/tegra/tegra210-emc-core.c |  4 ++--
 drivers/soc/qcom/qcom_aoss.c             |  2 +-
 drivers/thermal/khadas_mcu_fan.c         |  7 ++++---
 drivers/thermal/tegra/soctherm.c         |  6 +++---
 drivers/thermal/thermal_of.c             | 15 +++++++++------
 include/linux/thermal.h                  | 16 ++++++++--------
 15 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index d5f864b360b0..8e5926b06070 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -1076,7 +1076,7 @@ static int amc6821_probe(struct i2c_client *client)
 				     "Failed to initialize hwmon\n");
 
 	if (IS_ENABLED(CONFIG_THERMAL) && fan_np && data->fan_cooling_levels)
-		return PTR_ERR_OR_ZERO(devm_thermal_of_cooling_device_register(dev,
+		return PTR_ERR_OR_ZERO(devm_thermal_of_child_cooling_device_register(dev,
 			fan_np, client->name, data, &amc6821_cooling_ops));
 
 	return 0;
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index aa159bf158a3..1c5945d4ba37 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -841,8 +841,9 @@ static int aspeed_create_pwm_cooling(struct device *dev,
 	}
 	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
 
-	cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
-					cdev->name, cdev, &aspeed_pwm_cool_ops);
+	cdev->tcdev = devm_thermal_of_child_cooling_device_register(dev, child,
+								    cdev->name, cdev,
+								    &aspeed_pwm_cool_ops);
 	if (IS_ERR(cdev->tcdev))
 		return PTR_ERR(cdev->tcdev);
 
diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 64b213e1451e..2505e9fac499 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -309,9 +309,9 @@ static int emc2305_set_single_tz(struct device *dev, struct device_node *fan_nod
 	pwm = data->pwm_min[cdev_idx];
 
 	data->cdev_data[cdev_idx].cdev =
-		devm_thermal_of_cooling_device_register(dev, fan_node,
-							emc2305_fan_name[idx], data,
-							&emc2305_cooling_ops);
+		devm_thermal_of_child_cooling_device_register(dev, fan_node,
+							      emc2305_fan_name[idx], data,
+							      &emc2305_cooling_ops);
 
 	if (IS_ERR(data->cdev_data[cdev_idx].cdev)) {
 		dev_err(dev, "Failed to register cooling device %s\n", emc2305_fan_name[idx]);
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index a8892ced1e54..084828e1e281 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -592,8 +592,10 @@ static int gpio_fan_probe(struct platform_device *pdev)
 	}
 
 	/* Optional cooling device register for Device tree platforms */
-	fan_data->cdev = devm_thermal_of_cooling_device_register(dev, np,
-				"gpio-fan", fan_data, &gpio_fan_cool_ops);
+	fan_data->cdev = devm_thermal_of_child_cooling_device_register(dev, np,
+								       "gpio-fan",
+								       fan_data,
+								       &gpio_fan_cool_ops);
 
 	dev_info(dev, "GPIO fan initialized\n");
 
diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 56b8157885bb..3466edd7d501 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -794,9 +794,9 @@ static int max6650_probe(struct i2c_client *client)
 		return err;
 
 	if (IS_ENABLED(CONFIG_THERMAL)) {
-		cooling_dev = devm_thermal_of_cooling_device_register(dev,
-						dev->of_node, client->name,
-						data, &max6650_cooling_ops);
+		cooling_dev = devm_thermal_of_child_cooling_device_register(dev, dev->of_node,
+									    client->name, data,
+									    &max6650_cooling_ops);
 		if (IS_ERR(cooling_dev)) {
 			dev_warn(dev, "thermal cooling device register failed: %ld\n",
 				 PTR_ERR(cooling_dev));
diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index c8f5e695fb6d..aea0b8659f5f 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -857,8 +857,10 @@ static int npcm7xx_create_pwm_cooling(struct device *dev,
 	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%pOFn%d", child,
 		 pwm_port);
 
-	cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
-				cdev->name, cdev, &npcm7xx_pwm_cool_ops);
+	cdev->tcdev = devm_thermal_of_child_cooling_device_register(dev, child,
+								    cdev->name,
+								    cdev,
+								    &npcm7xx_pwm_cool_ops);
 	if (IS_ERR(cdev->tcdev))
 		return PTR_ERR(cdev->tcdev);
 
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 37269db2de84..e6a567d58579 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -685,8 +685,9 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ctx->pwm_fan_state = ctx->pwm_fan_max_state;
 	if (IS_ENABLED(CONFIG_THERMAL)) {
-		cdev = devm_thermal_of_cooling_device_register(dev,
-			dev->of_node, "pwm-fan", ctx, &pwm_fan_cooling_ops);
+		cdev = devm_thermal_of_child_cooling_device_register(dev, dev->of_node,
+								     "pwm-fan", ctx,
+								     &pwm_fan_cooling_ops);
 		if (IS_ERR(cdev)) {
 			ret = PTR_ERR(cdev);
 			dev_err(dev,
diff --git a/drivers/hwmon/qnap-mcu-hwmon.c b/drivers/hwmon/qnap-mcu-hwmon.c
index e86e64c4d391..c1c1e9d6f340 100644
--- a/drivers/hwmon/qnap-mcu-hwmon.c
+++ b/drivers/hwmon/qnap-mcu-hwmon.c
@@ -337,9 +337,9 @@ static int qnap_mcu_hwmon_probe(struct platform_device *pdev)
 	 * levels and only succeed with either no or correct cooling levels.
 	 */
 	if (IS_ENABLED(CONFIG_THERMAL) && hwm->fan_cooling_levels) {
-		cdev = devm_thermal_of_cooling_device_register(dev,
-					to_of_node(hwm->fan_node), "qnap-mcu-hwmon",
-					hwm, &qnap_mcu_hwmon_cooling_ops);
+		cdev = devm_thermal_of_child_cooling_device_register(dev, to_of_node(hwm->fan_node),
+								     "qnap-mcu-hwmon", hwm,
+								     &qnap_mcu_hwmon_cooling_ops);
 		if (IS_ERR(cdev))
 			return dev_err_probe(dev, PTR_ERR(cdev),
 				"Failed to register qnap-mcu-hwmon as cooling device\n");
diff --git a/drivers/hwmon/tc654.c b/drivers/hwmon/tc654.c
index 39fe5836f237..ba18b442b81e 100644
--- a/drivers/hwmon/tc654.c
+++ b/drivers/hwmon/tc654.c
@@ -541,8 +541,9 @@ static int tc654_probe(struct i2c_client *client)
 	if (IS_ENABLED(CONFIG_THERMAL)) {
 		struct thermal_cooling_device *cdev;
 
-		cdev = devm_thermal_of_cooling_device_register(dev, dev->of_node, client->name,
-							       hwmon_dev, &tc654_fan_cool_ops);
+		cdev = devm_thermal_of_child_cooling_device_register(dev, dev->of_node,
+								     client->name, hwmon_dev,
+								     &tc654_fan_cool_ops);
 		return PTR_ERR_OR_ZERO(cdev);
 	}
 
diff --git a/drivers/memory/tegra/tegra210-emc-core.c b/drivers/memory/tegra/tegra210-emc-core.c
index e96ca4157d48..065ae8bc2830 100644
--- a/drivers/memory/tegra/tegra210-emc-core.c
+++ b/drivers/memory/tegra/tegra210-emc-core.c
@@ -1966,8 +1966,8 @@ static int tegra210_emc_probe(struct platform_device *pdev)
 
 	tegra210_emc_debugfs_init(emc);
 
-	cd = devm_thermal_of_cooling_device_register(emc->dev, np, "emc", emc,
-						     &tegra210_emc_cd_ops);
+	cd = devm_thermal_of_child_cooling_device_register(emc->dev, np, "emc", emc,
+							   &tegra210_emc_cd_ops);
 	if (IS_ERR(cd)) {
 		err = PTR_ERR(cd);
 		dev_err(emc->dev, "failed to register cooling device: %d\n",
diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index c255662b8fc3..259c41f0c34e 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -381,7 +381,7 @@ static int qmp_cooling_device_add(struct qmp *qmp,
 	qmp_cdev->qmp = qmp;
 	qmp_cdev->state = !qmp_cdev_max_state;
 	qmp_cdev->name = cdev_name;
-	qmp_cdev->cdev = devm_thermal_of_cooling_device_register
+	qmp_cdev->cdev = devm_thermal_of_child_cooling_device_register
 				(qmp->dev, node,
 				cdev_name,
 				qmp_cdev, &qmp_cooling_device_ops);
diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index d35e5313bea4..21b3d0a71bd0 100644
--- a/drivers/thermal/khadas_mcu_fan.c
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -90,9 +90,10 @@ static int khadas_mcu_fan_probe(struct platform_device *pdev)
 	ctx->mcu = mcu;
 	platform_set_drvdata(pdev, ctx);
 
-	cdev = devm_thermal_of_cooling_device_register(dev->parent,
-			dev->parent->of_node, "khadas-mcu-fan", ctx,
-			&khadas_mcu_fan_cooling_ops);
+	cdev = devm_thermal_of_child_cooling_device_register(dev->parent,
+							     dev->parent->of_node,
+							     "khadas-mcu-fan", ctx,
+							     &khadas_mcu_fan_cooling_ops);
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
 		dev_err(dev, "Failed to register khadas-mcu-fan as cooling device: %d\n",
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 6a56638c98f1..d8e988a0d43e 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1707,9 +1707,9 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			stc->init = true;
 		} else {
 
-			tcd = devm_thermal_of_cooling_device_register(dev, np_stcc,
-								      (char *)name, ts,
-								      &throt_cooling_ops);
+			tcd = devm_thermal_of_child_cooling_device_register(dev, np_stcc,
+									    (char *)name, ts,
+									    &throt_cooling_ops);
 			if (IS_ERR_OR_NULL(tcd)) {
 				dev_err(dev,
 					"throttle-cfg: %s: failed to register cooling device\n",
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 8c49d449d43f..b59d2588ff7a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -557,7 +557,7 @@ static void thermal_of_cooling_device_release(void *data)
 }
 
 /**
- * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
+ * devm_thermal_of_child_cooling_device_register() - register an OF thermal cooling
  *                                             device
  * @dev:        a valid struct device pointer of a sensor device.
  * @np:         a pointer to a device tree node.
@@ -570,14 +570,17 @@ static void thermal_of_cooling_device_release(void *data)
  * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
  * to all the thermal zone devices registered at the same time.
  *
+ * This function should be used when a cooling controller has child
+ * nodes which are referenced in the thermal zone cooling map.
+ *
  * Return: a pointer to the created struct thermal_cooling_device or an
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-                                struct device_node *np,
-                                const char *type, void *devdata,
-                                const struct thermal_cooling_device_ops *ops)
+devm_thermal_of_child_cooling_device_register(struct device *dev,
+					      struct device_node *np,
+					      const char *type, void *devdata,
+					      const struct thermal_cooling_device_ops *ops)
 {
         struct thermal_cooling_device *cdev;
         int ret;
@@ -592,4 +595,4 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 
         return cdev;
 }
-EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
+EXPORT_SYMBOL_GPL(devm_thermal_of_child_cooling_device_register);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6d1862ac187f..e6328234a42b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -205,10 +205,10 @@ thermal_of_cooling_device_register(struct device_node *np, const char *type, voi
 				   const struct thermal_cooling_device_ops *ops);
 
 struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-					struct device_node *np,
-					const char *type, void *devdata,
-					const struct thermal_cooling_device_ops *ops);
+devm_thermal_of_child_cooling_device_register(struct device *dev,
+					      struct device_node *np,
+					      const char *type, void *devdata,
+					      const struct thermal_cooling_device_ops *ops);
 #else
 
 static inline
@@ -232,10 +232,10 @@ thermal_of_cooling_device_register(struct device_node *np,
 }
 
 static inline struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-					struct device_node *np,
-					const char *type, void *devdata,
-					const struct thermal_cooling_device_ops *ops)
+devm_thermal_of_child_cooling_device_register(struct device *dev,
+					      struct device_node *np,
+					      const char *type, void *devdata,
+					      const struct thermal_cooling_device_ops *ops)
 {
 	return ERR_PTR(-ENODEV);
 }
-- 
2.43.0


