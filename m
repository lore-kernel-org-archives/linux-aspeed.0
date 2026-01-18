Return-Path: <linux-aspeed+bounces-3388-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D7BC98315
	for <linux-aspeed@archiver.kernel.org>; Sun, 18 Jan 2026 23:22:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvV2g34V2z3c8h;
	Mon, 19 Jan 2026 10:21:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768759809;
	cv=none; b=VcsGprXUoulNhTlKzpZhoSrU4cYJmpWlIXcD+7MqCsekJcxTDIpxy/cpbjQ2VuxpQHArQ+UzOoI72O2UWqbww3mAQZqytLc0ChS54O63/zDQtSwiVc6qTkfdvyHgeu3KY8gm5p0NvRWavqV13IqbNFfoBRn4DxWZ0WXEuDyszlAvYDVEV1OwrCy/I312U9R0CN6nQeegPKmHXR+iRCAiYV2ESzeYIFjGeZuNAuYvrCyDB44/zHtcL6WY763E+0fXPo0qZiS7e6lVzJw7t+cy7Y0aBqUffCq1FZJeK8eAGb6U+qk2fMQTTw2G8nhgW4bBr1N/LHwtldRFSAT5Nt3sWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768759809; c=relaxed/relaxed;
	bh=e91dx2Lt0A/p1SGAlZ5HpZ8yspCC620dBzh1TkoZPcU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U3HWjQLe5pJ++ZL4O+D1prs2iD7JyDQTIt17KnvirbZCVGI/gdrCcbj6cSlo2JNGArUDBB8EIwWRQtRhgd/5UPFd1OvjT0BYUE/oWvXM23QOfHMywwqgnNpDPub9mKluu43qZBZ2sx+08FzgbI2wEJwDEADVvw3d7QAKmMkIiD+Z01BnpnNbW6P2E0LMW2r5AkEmqTDHESmXO510CZIq/RJquUBOxVybB9sYy4u/p/mE0Fe52KshorgiI1m9vWWPcD3ubexxBhDMHVhQFvLJ3zxPxFoxNPfxi1u0Absl7L8uC67nTTijoIQsDcTS5ZFtrB+sM2CPF+PIo1YxF686eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ln8b4JIB; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFXz90yz; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ln8b4JIB;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZFXz90yz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=krzysztof.kozlowski@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvM7h1clvz2xpt
	for <linux-aspeed@lists.ozlabs.org>; Mon, 19 Jan 2026 05:10:07 +1100 (AEDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60I3vKm51403634
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e91dx2Lt0A/p1SGAlZ5HpZ
	8yspCC620dBzh1TkoZPcU=; b=ln8b4JIBtx2p2ndYbdcg7hBkEyb8pP5Fi+t9R2
	NB1P7oS6+ntgck1paeRGEG8rADyKM5ndWs1zZ+0RDq5mVA20ILOZTncnS3WdLapj
	TMk3+Ewh2PB2rVic9DZcHeU5jFpYMoABdSAjGNbAWlZrcyA/s+7t0xc6gaVA8eX7
	8QSsd2x7S2YKQWVdl5sEJHTqIKs7GeR4L5HbZLzL/s61kBoysGTYHvJpvKSiyKVE
	VbErM39U3kx54UlqVR1FsyaYP+c683FhscWbonpJQ1M5STzco0LUqT54xVB3qcmS
	JyVCbC0XT7qfVkbZCwUOfTtI86DXgn86xnEgU6+1vgUHGC8g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4br2t72r37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 18:10:03 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a0ec2496so717945985a.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 18 Jan 2026 10:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768759803; x=1769364603; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e91dx2Lt0A/p1SGAlZ5HpZ8yspCC620dBzh1TkoZPcU=;
        b=ZFXz90yzQfGccWo0WkWj2XreIsatX9CmVjeAZ3JoAWjfRLuQOAQPg0XRRDw7YfxuTX
         12s3FfuTLbGMTok4wAODv04wEl/7RvfIa2wZhM1jvh+aLY7nfiEiqZXwYCIiMiPqWyil
         MsyLoQNXOlgAeWySGWXpNZJ+Pk2jF0ZY71R+BvTQJ/faIFusGagf+OLPSh7vNmnU9iIh
         P6pLCI/bTC09hbJxThHswVi8Z4FLYtdjaP1c2kBFYlyd4CYkEGr0UT9F5jBQiAULXWRa
         9TC73PoJCd7LeBq3kK2JhTUqxizLayWN2NUsWseOzjeDFQX3GFXhuqY7xpyGkKxUKiko
         yOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768759803; x=1769364603;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e91dx2Lt0A/p1SGAlZ5HpZ8yspCC620dBzh1TkoZPcU=;
        b=RVdBXbdL9SR8IPV4iLa+vEsZ3R/k/J1563Y7Ky7Oewo+0Ldr1sSTNp4nYxdnUdYZFz
         7Z/FXxBENBBubN8rExdWYlzkLZyN+ZbYVktuyOTCzrJxJdQVJ/maJhifTvL8ehj/ghjY
         wxgL++CGRoFWIt+ZY5KrI48xqg0WiowZiMIhQDP8O1bTbZPWubFOrAxLt4cjmwaswFAX
         qrmD0DJp7uxfjUGmVi/KrGq4em+w4efeeIRfx08SfCVARnDL1Cr7Tqq5I4dOaHp5No92
         RC1MtILgcvbnt/9Xc3RlULCEfpLDIrdZp6MPZkWX8eAY9mUOKle8BGVurKBvI7fTCEe3
         ihdw==
X-Gm-Message-State: AOJu0YyxOFpGwL9rwMqaQq5pZzljsWbyv6OqINfjFcBvCZPQlcEodw+i
	rpPdUqOsHAuKWoL3AEpF3/TVhuWNd95ehUu6ge7gHHvGqw6lNGBpJOwE1JxHzhBpAS15nk19Y3P
	MiiakJDinRZVMQsctSdkAB9j0s9iwl1/CTUWx/2OsUOw++py214NfU0Iv2SV226aoKF2E
X-Gm-Gg: AY/fxX6GLagHYSyvAp8OZeJIzK5n0shZJd+l/JCXzfJ/v473bavdVsTyJiUm9oDizQW
	6Sm0yG3umxWgzNrcrfwamVudGchDnRYEcZDaxrG3D+ozsbOsx0EIQvnT2DLdGwjpudeiAeVfG9Z
	J/Mpi9seYjhODvzcYVSUl9Gf4vMskToMV4gT5QHtov81agTSVdVKH1Ufl2NTRMiMxzZGLbP4360
	Pd8rF5aKBfSjIqXoPVKuIiDbbtVnZq1zz5IhfQ7OEom+oZ4uRgwVxFbUhOaZrrna6Sg7c2zEKMW
	dv34tEmYvQzidp+6/pCYWSxnEIWUUm7eG354aZvqqR7vR4xJljlloyI3EPxqQOj+zUj8Rxct53/
	eAe+tZDC6ljgeO9UUD0Ir5q1he+/pywHqvA==
X-Received: by 2002:a05:620a:19a9:b0:8a6:e2b4:ba73 with SMTP id af79cd13be357-8c6a676deefmr1375660785a.51.1768759803291;
        Sun, 18 Jan 2026 10:10:03 -0800 (PST)
X-Received: by 2002:a05:620a:19a9:b0:8a6:e2b4:ba73 with SMTP id af79cd13be357-8c6a676deefmr1375653585a.51.1768759802656;
        Sun, 18 Jan 2026 10:10:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe44b37sm62162085e9.12.2026.01.18.10.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 10:10:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 00/11] pinctrl: Some code cleanup including guards
Date: Sun, 18 Jan 2026 19:09:23 +0100
Message-Id: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIANMhbWkC/4WNQQ6DIBREr2L+ut8IotWueo/GBQLVnyhYUNLGe
 PdSL9DNJG+SebNDMJ5MgFu2gzeRAjmbgF8yUKO0g0HSiYEXvC4YE7iQVaufUE1G2m3BYZNeo27
 athdt2fS8hrRdvHnS+/Q+usQjhdX5z3kT2a/9Z4wMC5RMVFdeN5XS5d2FkL82OSk3z3kK6I7j+
 AIC5y64wQAAAA==
X-Change-ID: 20260114-pinctrl-cleanup-guard-d899b4938b26
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2196;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=dKxtqE6F8oVTPGmj41LTMmFmCHa0XUBAz9pzJ7TKy6A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpbSHgS/sC9MoC46kLct9nO207FP02f+ZKWuWF4
 x/5aXRVPPqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaW0h4AAKCRDBN2bmhouD
 14R3D/4jKkbCQoTMPrMXhhxCHhrjeKIra3ZsTo8nPBiXx1ID7N9lPwzEIYwEZO8B49U/Q01dq5+
 fUCazLvlHLe2RVwJypxPbjPXDZEh3HAfgP6uvjK+JegThArZiW7Msp/3kWgL7JRn2WAZr4FJOVE
 MhnYZ0KcknqqK3deee26SYH9o7TYNQpnT5HC5fu4m8bFgWNDfZ4f8EMv1rKquIp/HWdPb437xjK
 gdyrQCSvr2uGwRe7V3JHT13jrs8B1if8tfgU1U64WlPSQlcIvvft1IJX+mbe8rzvpggj4Uu7hem
 +pTVezsrkvRW5z+WRI7I7opzoBaGi0qFTUibXhzbG42KeuGaJCCvY3r6Kf+mgf6aaRfPhvR22Yv
 EfcagSijmlL2S5tZv8KR2yes9TEOLqDFKf/P6IrD/+WnGPgNf74qHRpqPnmIPVcACbbA1PgkREr
 zT5pT2C8Thpf7dvRv6PzP4FJs5pDS1EfusuHXjRKP740bHrWrLOFVFvVau9MYu7Ft064VpIS5KN
 BHE9uwTEtyCczL+C7z2TbfRGHmW2/mQqt9z/bk9EJJLp7iGmOsat40UDsozN9a/2VAKC2S8GziS
 HzceKkh1lcWCJVgmwBcKgtQnMHvwF0PT/ni39xYB4PY+aRw8ESy90SUN8GoKJ4qvhbAiSolNd8w
 X8uqy5r2f8iL1YA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Fdc6BZ+6 c=1 sm=1 tr=0 ts=696d21fb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8
 a=SAbWReso6WKF-fSag6gA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 47Gdd-ntObhVSzOTv5sBLg78usj31YSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE4MDE1OSBTYWx0ZWRfXzz+fuNVuYHEw
 b9XQuDkXbty6TKx0JQiB9l0wX4ABq0ZjNzcn4uzhvu1CfCzUVoNeLNi0AqiXXHZPtWFpYKdVBKo
 kxMr3UI24fGizVIfLWidBgqgsgK4eFYECYUQ7VZA1fBUNVfjfZ8rZDRr9+j4y6JwMqO3O1Lc0lc
 ATR05H/w9Hln7FUvkCwZDyeLrZOK1bd8oZufvtaPZmvfMSZ2sd6nOLIeAaC3oAk429KiEFRluOU
 ZxGukCiUEFPR3kHEWU5FFegjKcJ5XN90No6JoXG+bd5wNyrLybex0Oc/E2TCrcchU3Xs+oLEKKM
 KWgX1z0EdBoTgHNJZcv+OEJu7TG5F1DQthdc0Z4lfS9hHYddg6JCevh/xAYjlS+UucvQ5eY4xZC
 zl/0+ZxJ4g4iJAQSke4zPt8Jho4WwKCGWhzNUxtP9Z8+zcOgB5kWB8QCh616iyyrxqkl6wEYmnc
 Jx2mVSFmq5HwlcyvHBg==
X-Proofpoint-GUID: 47Gdd-ntObhVSzOTv5sBLg78usj31YSb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-17_03,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601180159

Changes in v2:
- Patch #9 (pinctrl: tegra-xusb) - Drop stale mutex_unlock (Jon)
- Add tags
- Link to v1: https://patch.msgid.link/20260114-pinctrl-cleanup-guard-v1-0-a14572685cd3@oss.qualcomm.com

Few cleanups - from unused headers - or code simplifyings, including
usage of guards when beneficial.  I did not conver cases where guards
would be mixed with gotos, because this is discouraged practice.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (11):
      pinctrl: aspeed: Cleanup header includes
      pinctrl: starfive: jh7110-sys: Cleanup header includes
      pinctrl: sophgo: Cleanup header includes
      pinctrl: amd: Cleanup header includes
      pinctrl: aw9523: Simplify locking with guard()
      pinctrl: microchip-sgpio: Simplify locking with guard()
      pinctrl: tb10x: Simplify locking with guard()
      pinctrl: tegra-xusb: Return void in padctl enable/disable functions
      pinctrl: tegra-xusb: Simplify locking with guard()
      pinctrl: rockchip: Simplify locking with scoped_guard()
      pinctrl: st: Annotate st_pinconf_dbg_show() as holding mutex

 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c         |  4 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c         |  3 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c         |  5 +-
 drivers/pinctrl/pinctrl-amd.c                      |  2 -
 drivers/pinctrl/pinctrl-aw9523.c                   | 53 ++++++++++------------
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |  6 +--
 drivers/pinctrl/pinctrl-rockchip.c                 | 19 ++++----
 drivers/pinctrl/pinctrl-st.c                       |  1 +
 drivers/pinctrl/pinctrl-tb10x.c                    | 17 ++-----
 drivers/pinctrl/sophgo/pinctrl-cv18xx.h            |  4 --
 drivers/pinctrl/sophgo/pinctrl-sg2042.h            |  6 ---
 .../pinctrl/starfive/pinctrl-starfive-jh7110-sys.c |  3 --
 drivers/pinctrl/tegra/pinctrl-tegra-xusb.c         | 30 ++++++------
 13 files changed, 55 insertions(+), 98 deletions(-)
---
base-commit: ba124fc31bca9f5158f9bc00ac5ce38154b57007
change-id: 20260114-pinctrl-cleanup-guard-d899b4938b26

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>


