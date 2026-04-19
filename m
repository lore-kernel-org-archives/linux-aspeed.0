Return-Path: <linux-aspeed+bounces-3928-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0528EA71A4
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Apr 2026 01:52:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzT581f3Cz2ymg;
	Mon, 20 Apr 2026 11:52:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776622980;
	cv=none; b=d4iBnYa7CD5YJDh+qigLMtvE5jkFs+7I+TTzXxt0goeVj2va0Rz91OiStxpAxA1gLQDEbKrQ4CgrHF6QU3cLg7/h/tHAbQaS7JNPbf47kZdSZWTomPIoPp+Ihim84uabURl79ZGqD0cQYlTBpEzypi9laPk1G7GwocH/k8FoHsrRjgVw06pCm7v7t5W2MH9Sce+wnJcBjBdVSpwAr1S9aKtJZK5kwwmQ8b+U0WfV5Rg5yR9VoeXeIBTnpC0G2Oto1Nk8NCUwDZ8c+wAUtrWB9r7+rVksD4z8S9jaOCWBqVIKEGjJwq6eXeUXEXUzDQqxR4ARp9Cp2MFWD76QqCRjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776622980; c=relaxed/relaxed;
	bh=wxDS+E6AjtQ7nckN1UafhZkE9UqxJp4Wfu7o2Vgej8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqRp7Y1h7nbBUhBxRaxyFyilMtHiplNNE3Lf18QXguQ/sityqvea3QGoyDUi6eS1pKNbRjK+AytlBMgnMUDEQVABcZ068/4fstpEBNx91okRNgOur8swBhGth3URrJbLeOwURFORqGgs5mnJ1Esf1n0fAkWz+lLml/oy4girg3IJxfcs924XH+tHIAb2j2alh9FK99eMH6pWQmFK63K5GOnOjZbvrEQCAvdDfEShPQydo8be/Jr7p0tdtuad6ieY497UYwiXZfiv47zQB9WCtg3Sb1FvNrRNcGDtNT4PuAGQW2Iz0vHM8IKB1GbnmutIwESf7yhOnWlOfThrAKW0rA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TXqzmNlL; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kDkER/Uc; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=daniel.lezcano@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TXqzmNlL;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kDkER/Uc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=daniel.lezcano@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzH6V190Lz2xSB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 20 Apr 2026 04:22:56 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63J4f3Lf4182469
	for <linux-aspeed@lists.ozlabs.org>; Sun, 19 Apr 2026 18:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=wxDS+E6AjtQ
	7nckN1UafhZkE9UqxJp4Wfu7o2Vgej8Q=; b=TXqzmNlLXDsR9aIx3b5BDLVYJ6g
	Cqc7dW4U//Xfbt4HvRlStD6bMHWTSVgePM9INkU/md330W6dK/s6hQc7vLrJolSs
	LJBHNl7s8tXl1nmR9VfVdKqkTwuRX8kWzPoSPRcCMnVQsambtJPfdZgqEQbrbKxk
	UDAlwAzKjREIld4e2RgZ8rtKj0wMbyEc6ClVuph/b5ykuzWqoHPPbqIo5pH+2K01
	BSU/pHT7V5FiVgZQqk+r0tlQVCFi3phUDaEPMjlLVwQHAfZAb+G0mlNbr/57cci4
	lWY0Aglyz1Iohoaa1NKYWPBDecugrazL/m3prF4DE5VN90CDY0WkU/BKPkA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm19fu321-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 19 Apr 2026 18:22:52 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d76f460b2so62616361cf.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 19 Apr 2026 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776622972; x=1777227772; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxDS+E6AjtQ7nckN1UafhZkE9UqxJp4Wfu7o2Vgej8Q=;
        b=kDkER/UcSMaUzn84QU1p2dNpWbPSNzjKkpVT0p79kn25TmZYzxE5tPj/jl/MLAHCKH
         a6iYj4FPtLpzDecqGnjY23JLXtZseVsj+V2AL7AKPC7axpDpis8sxR68xz9fB45crrjZ
         CBVGiW9DWtCcs42+2PJKyothvkIVu7fNECy1YvXDRA8tHiWHHz2SxOrkc6A056nJ4dpM
         H/UWhKFEjeNG84f9+XXOMvURJUK6gTukUVmKiqyp7qvyV7Qm+AqmEqIPYwTraDfKfQL4
         3NooaQwsTIUZcOrVTnaeDmEPrtSRTNagBnfsExnyAup9hGQeyVrryz5fINZWT+j3wZgk
         q0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776622972; x=1777227772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wxDS+E6AjtQ7nckN1UafhZkE9UqxJp4Wfu7o2Vgej8Q=;
        b=HnBsJdWfvOBYvvsubV46G6RXeMlvP1jz3PIR3dBJvQVs7l+BlGtofPdL8OWkfNUI3Z
         /9yFQTIdYLWqquwEHpKcR2wzEtTY2ASHKm41DnslUKRH7YtJwS3/FzZf9I1p1davAN1g
         UGv8l5dDxTiLhHhTNuCycKREDFj0gRmcqDqb3DmWsreGiGqPHr4MXNi7m+/O6p9fJgUE
         sOrwrSakNoK/jDIc3a2cnyT76pBbx+gys1u2icKLcgWSwCYSFpFW5taJPoOJsS8KnDon
         eEXJCEjch+dn5ApqasX3XeaEkMfm+iqONE/ArnO5ijUy015h1QIBgBl5fYv2fsAM+woh
         Vhfg==
X-Forwarded-Encrypted: i=1; AFNElJ99ZVz03wZrQwBSf6WcrE3/JWQH5VoGXH1UodztcJMdyLlx4MOy+WXuupZpFSGNu3RcKIizXs7L1yNR9gQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyWhZyD/mNV9viJ03DGiewBmfrKgW9tl/8TjW8Dt2lQsf0g6wEz
	5hOgQde+9YC6eG2pufkrTAVzyxSd6xmYNDuJN8RlZ8kpwe538byD7p6+TeYauf30E6HjG61yiKF
	6fDU70eqe/8ZFu4ZG1Zi2DvaBp+lAB25IG4CmRFYqPp+T65PJOcydV7rpm+zTzSVeFOxX
X-Gm-Gg: AeBDies0XTUF/CfCcXkpsz5oyhQViLlo8zcWpSB8j25AzVMmpXXHf79LXCYVV5zbbYc
	qnrv96XBpfD42yG6LpZlecpZASszHKOm1305hi8Jm7EP7knuff6JlKFvv2HQ4FBUCVq5c4QxaIQ
	8lLxV2Kq1HliUFZcnDy7Ofw9gqoZYJUCszONpLK2yG4tzJMzdzc+x/3cmwiH4JUsamkOTWrLmYo
	6LLBrArnvckSPpOh7x0ZNNMYbP5qe214ukqARNrQ9ly82UauHaDWyVcew+BLwO3GKYEaF1oCEM4
	vpzCxN2cJV3ctqKyYWNcyIvuNcuFQsHmPMFq5qzLQBs0PXayys/DHXe9ijvNUni9vpEcqnAREFD
	pCkiNIuI9y2oplTr0LwGjF2AmDrEcYv7AbMJzufO/4SIG3WKBDtW+Znsszfgf
X-Received: by 2002:a05:622a:112:b0:4ee:1b0e:861a with SMTP id d75a77b69052e-50e36940b98mr155537391cf.13.1776622972133;
        Sun, 19 Apr 2026 11:22:52 -0700 (PDT)
X-Received: by 2002:a05:622a:112:b0:4ee:1b0e:861a with SMTP id d75a77b69052e-50e36940b98mr155536611cf.13.1776622971624;
        Sun, 19 Apr 2026 11:22:51 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:22:50 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
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
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
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
Subject: [PATCH v1 10/14] thermal/of: Rename the devm_thermal_of_cooling_device_register() function
Date: Sun, 19 Apr 2026 20:21:54 +0200
Message-ID: <20260419182203.4083985-11-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfXwHwvo4tjRNCr
 xEiUYvGVftbUCwrJ4EPE1i17Y9isF2uSxc0CPjpCV5M8ayKNP34u2QMuQ+jWVXKCwJZeuZVGqH5
 wtH9Beov6Qwwt+8yRWxomthI2WkgxWUmXT4fVgwzXiil3c82HVAmOpy6A53tS3nZtiPhH80ZGEO
 foQjFtJKiyalelcpxQgAf6SN9pCaRAt1pzerdeEbze4tZ1VrI9Dx3VUX1DOGDkp/jZ/6HOHlmWr
 nM+2oNDnXIcVBvnTypL/q+mh1Lrg7HW8P2EjXEzUxYTAGEF9bT9UG2nod/pN0+dkCkz0Wg8/LC5
 wEaLov9LP8nV9DcNhyV6Ag1PQrI0LtKVJ1+vafGQskaJ9qqtexPZVVwuYGNtwrn8sKCKSqkUXew
 BQJH7Yd5Q6Apr3oPYHgAg4Qij9mxwBwJ3kqJAc850zboR/NOxUgRbC1Z88s+LEtwmBFC5F3Su9C
 zeH1I4vhe6JaOu27f2Q==
X-Proofpoint-ORIG-GUID: iK5Xvwlr21MtzdQK46QT-Pvr2FKuTUaN
X-Proofpoint-GUID: iK5Xvwlr21MtzdQK46QT-Pvr2FKuTUaN
X-Authority-Analysis: v=2.4 cv=FMorAeos c=1 sm=1 tr=0 ts=69e51d7c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=9QVJCMzFHTx7fD6CVgwA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1011 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604190197

The cooling devices can be composed with a cooling device controller
and a set of cooling devices attached to it. Until now, the DT
bindings were described using a node for the cooling device controller
and child nodes for all the cooling devices.

Recently, a new set of cooling devices were proposed with the same
bindings. Those were rejected because DT maintainers do not want this
format anymore. In place, a cooling device will be created with an
id. Whatever its meaning, the thermal OF will bind a thermal zone and
a cooling device by checking the device node pointer + the id are
matching the cooling map with the cooling device.

Actually this approach is consistent with the thermal which are also
registered with a device and an id.

In order to do a distinction between the old binding with child nodes
and the incoming new binding, let's rename the registering function
with a self-explanatory name.

Rename the functions:
	devm_thermal_of_cooling_device_register() -> devm_thermal_of_child_cooling_device_register()

Used the command:

     	 find . -type f -name '*.[ch]' -exec \
	 sed -i 's/devm_thermal_of_cooling_device_register/\
	 devm_thermal_of_child_cooling_device_register/g' {} \;

Did not used clang-format-diff because it does not indent correctly
and checkpatch complained. Manually reindented to make checkpatch
happy

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
 drivers/thermal/thermal_of.c             | 12 ++++++------
 include/linux/thermal.h                  | 16 ++++++++--------
 15 files changed, 51 insertions(+), 43 deletions(-)

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
index 9649c6611d5f..a50b1b0f1f48 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -793,9 +793,9 @@ static int max6650_probe(struct i2c_client *client)
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
index a543ab9bee6c..742f571200fa 100644
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
index 9d3eb3be2db0..9911f3ec0f40 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1700,9 +1700,9 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
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
index 3d2fb8f37b9c..ba5093f612d0 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -550,7 +550,7 @@ static void thermal_cooling_device_release(struct device *dev, void *res)
 }
 
 /**
- * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
+ * devm_thermal_of_child_cooling_device_register() - register an OF thermal cooling
  *					       device
  * @dev:	a valid struct device pointer of a sensor device.
  * @np:		a pointer to a device tree node.
@@ -567,10 +567,10 @@ static void thermal_cooling_device_release(struct device *dev, void *res)
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-devm_thermal_of_cooling_device_register(struct device *dev,
-					struct device_node *np,
-					const char *type, void *devdata,
-					const struct thermal_cooling_device_ops *ops)
+devm_thermal_of_child_cooling_device_register(struct device *dev,
+					      struct device_node *np,
+					      const char *type, void *devdata,
+					      const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device **ptr, *tcd;
 
@@ -590,4 +590,4 @@ devm_thermal_of_cooling_device_register(struct device *dev,
 
 	return tcd;
 }
-EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
+EXPORT_SYMBOL_GPL(devm_thermal_of_child_cooling_device_register);
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a8e870ca2e27..6535353ae83c 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -206,10 +206,10 @@ thermal_of_cooling_device_register(struct device_node *np,
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
@@ -233,10 +233,10 @@ thermal_of_cooling_device_register(struct device_node *np,
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


