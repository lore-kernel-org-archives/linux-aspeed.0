Return-Path: <linux-aspeed+bounces-4501-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF08C44524
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:31:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DPB3V7Lz3c5q;
	Sat, 18 Jul 2026 14:31:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784192576;
	cv=none; b=I3MXQ/lDS3JEqVi0XCLe7o1cq6GDKoZ14pfutJYpPBJlwtftoQIO9vOuzMDbDZoYE5tNK5QJlyYBp+TL/rur6QoV0zUIPzNkiCR+P1tFIkO9nDoRJCiPqM4YPS4JOoLAYxszXIhqXWWyQ4cHArOznZKJhrJpyS1bL/NHa7qGj6JRm4qFnM1wRhpUDpdKJaumqW9ppoVv9rKcO8BFrJszypGdz4BMdYeROxlxVaMrhWhH4ad0x1FwIqGdYthoRQfkVai6aRxbi9BYYPWE11g2vzB3WsC1MVS1E0ts1Rg+ZV81ZHZplxhpNSr+8KIlEZj/tzBthRU7Ek8Z7JkGKtz2pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784192576; c=relaxed/relaxed;
	bh=ublGuK2L8LkFww+I8N33BPNROB2FHlpEAQq3id5WGFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fN4aQz8AaPOS+GSvHhn6ECiFWx0M24qZMA0VaFrhQZCO1FvOtmzbsWK3iY1g5douiik90FQOuHMf2MwXfj3driOMmX8B5ZUeO3R3A9eAAEqy8eF00a4tGXglA7RzcZvWiDg94six4SL4Abaan4bzGdaBcfH+nk4GSiuOzLQNRiOaJlfvFfKCx43hqvYF303gp6Y/7/u5ZI7ZmyXMHGEC1Oa6daKH8TO5oiyD6JXmXXJ9hnNFs4ZDwdOyfoFc4Iqou+kdHLCxPKg4Wm0RHtyK0zyoYA+74VsCEZlCVpOw0gXCOGb6wRfgfpnN0FWk0yN2g7ZWzZklIxKMY5PS11Ub8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+6oa4N+; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XOSd6ZK0; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+6oa4N+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XOSd6ZK0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h16Wf1K2Yz2xlZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 19:02:52 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7Dvhp2115247
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ublGuK2L8LkFww+I8N33BP
	NROB2FHlpEAQq3id5WGFg=; b=V+6oa4N+LgdZwM5OLLMLzcpu+E7cXBM2MjtCEL
	paYclXuXv45UgosyH+b9jNiKowTXide2Ruhznp2OXf7vih/6t8cP9bhAYTrzPSt/
	jwyj/Kl71gtpnD4kZrMhdE08ty+lQDmLltP4kJyeqX/U1d3yIHP+be9yi19Bjbyj
	SH5VGFy1EQnvdryRsoFC4scN7YkeMd7XyOzadCndh4iPReYTiK/1SpI9rejhWLFs
	J889JR4PrWpy90cTbVS6USh7agUADPwTnK6TH/bG9yig6w22YsSkxL9A7Z4ZAD3m
	qqv71vdY/Wi3BhnG0Ug0fBLjBQLCOvcd6SUZuiNjnMDruDiw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1jyc7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:02:49 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so124154535ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784192568; x=1784797368; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ublGuK2L8LkFww+I8N33BPNROB2FHlpEAQq3id5WGFg=;
        b=XOSd6ZK0mJMr52X+bkkZwcZ3HhHTYcBTVwQ/+BMuwObdOnq0Fgc/0uLgoJikRkkMu7
         aMoS0u5ksKW9MyBucjdHoWaQp0m42+wxzcQXWB3yHck+7DEM+zE+c1sbR76xSIBisbP6
         SpS9bNz0Qg/btoaaGUDw0mBZqpUp+e6HlW1qIdyJ98+p6GfQZZX6snvQPmIwF2maR3gI
         c/UrZjxw/YSd5Z8C8bFt73l4vln7E/BP511GOm0wI5v8iSc+Zk704DGesj4SlD5BSaJp
         Lxt39K8J0n5Qw1IXyeyoVDMHzD0zgG8ttC73JcOsR40gNftwnaOrzGHy62F7Rp0FWKvL
         KroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192568; x=1784797368;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ublGuK2L8LkFww+I8N33BPNROB2FHlpEAQq3id5WGFg=;
        b=kIVODzi+nzxsIBQHM7WsI5evROD8/PxeYbpcdGVd5BJFw+otKZ5NX8pygHZd8Oyk55
         DFYpTbd1v+o8s6uVHqvohPNw50MvaNBrT8c9OrbC9zcopgSvxctDI+inq4jWxR5K26rn
         cC0hN/NJVJEayCajZkm12D5NeCDXFiO+ZP29o+vbh+zdH0W7D4TxM8bRmABC+HC0Dsz8
         oXF0BySyNUchI8/rT00clnkqGXc6qZgyIUjoosn5a1YF6g/1m6xC422WUEN33lJD5CmX
         u2QdPF2xNzy2Fx0uFWn7lF9yxsCswtrM/wsdNKEPAssPqdj8xRDBdcBUXIcOR0Pc6ibQ
         HAZA==
X-Forwarded-Encrypted: i=1; AHgh+RpkJxpcvfcVjSldefFAAsyYRpnSLc2VxIyVAvVrtllrDIpRGh4AWqHw3qGl+pkY94Gbl/8NHItvZQQ3YiQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDWsEoDdFZKfgw77qyvNCMyy6eDXpA26kDHPFPNudVoirX/q5j
	WYY2Yqr71U1AgNK/lK9td6xOCdaCbfhBH/zuWWrwfI6ruts8dmmiiAfmYjo/4k2TrTp2n3yFEA2
	S0T/y2+6UeBhmbV4nF31xnE2NQqklBM3YTnosf1tyL95W6kld07RH7VVNlrSX8x/nTQFB
X-Gm-Gg: AfdE7cnNcZRgIuSzLB1+n9rgci+MIWNKdIegYlDxfvkj5fXhDBiY7Dl7PnqwE917C7K
	qr59bBVKjYv4DvaaezH3rI1ix3DT9MxIzAjjumxTld9TbXuouGCj/emH71K2mzmGDd5j0Pi18vP
	q0cNjGqVA/e0GfcRzWC776tZqk9o04RUc3Lw7ktKhgDmYqA7giQiox5w9us9tD552WO6Fh6EU+4
	umcobNif3oecEREB5uIhbZ3/SV4kbqsJNyRsbtnEm+WoG740LlavIh+7cWrU3xNxZGEl1fSJ22w
	EJpbePZJbhBrykCA3/NFFlxJkkJRBl0vWel8OhEW3ADcvl9iY8jqICQF3OAjSKnlvHo0PWrS7Qr
	fR3f0/vz+tV/DwGaLAztB
X-Received: by 2002:a17:902:d4c7:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2cf03bd52fcmr58054705ad.4.1784192568034;
        Thu, 16 Jul 2026 02:02:48 -0700 (PDT)
X-Received: by 2002:a17:902:d4c7:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2cf03bd52fcmr58054215ad.4.1784192567515;
        Thu, 16 Jul 2026 02:02:47 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:02:47 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: [PATCH v2 0/8] drm: replace simple display pipe users with atomic
 helpers
Date: Thu, 16 Jul 2026 17:01:52 +0800
Message-Id: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAKeWGoC/3WOwQ6CMBBEf4Xs2TVtUYye/A/jodRVq5RitxAM4
 d9t0auXSSaZmTcTMAVLDIdigkCDZevbZNSqAHPX7Y3QXpIHJVQldmKDl+CQresawqdjDOT8oBs
 UUotSmkpLtYdU7gJd7bgMn85fz339IBPz2i8R6NUnYvzGoNZMaLxzNh6KzGlpjJjJKCpUO8hDd
 8vRh/dyeJBL7/dt++/bIFFgvSFptNiWlSqPnnn96nWTYeskcJ7n+QMga11FDAEAAA==
X-Change-ID: 20260704-drm-simple-kms-removal-01a031c6a129
To: Alexey Brodkin <abrodkin@synopsys.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192559; l=4273;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=LslnXr/GYqt7lILfSX6H30ANs5TVBAPc61jkQsfXePo=;
 b=Qn3SgZ3Jcpq2dbsoxobIntKn1Fa949LtJINyO/lyXEjkZuMSQIFchq6+tnE8WqT7IXdz+1rFS
 ByTjQjwu366A0YatYIUCp3ydGB4Kf09fwhed1OK9kDkxik/D9RYfMki
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfXyNnuo0jMJKOW
 ia7v6o8TK+2N4LLcLmHJlHekPaqsUVMfWtjLo5aKTRMHJYE76XtBekZ8vrOy903xV602sSKZHhc
 ELvtUGn/ByuDgNPW7d/9obIGO6NJrvrl52n1SVQ+Dji/SmF+SIOMG2dIU0Y7X7T0n/UIS5UFy5b
 6FTuSqnitpE6JLbZzYz7D9xCeBWKVklrEW7MZPC8Kdti4JeFiKv4KTu4g3jcXl51UvINTs7VZ0H
 mbTT8a7lC6sxFFAopLb05fw1IjEWu5OJo5VILnL8VThWF1gZFsbTndSDfwo74HPMhQQ6DE3HEs3
 a90cpPnsS+fjlyGDi1euWNJ+2ufVsSktp/Ul80HPqkQ85qZwZIR7ITNs/Ra7MhXsqYqewrLcfIe
 bQy/tBlbImfgS0r6rg1g5d2j/F86PZzWm5YB79Qh7+hZV9ldMZWcpWj6VPcFgOat/DCkSb4mOD3
 E6bEs/TJGmOJykM3/iw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX70HrR3z1VmnC
 hLvKPDCCY0Gk1W9T+4GCT8lMdIfP9N2mYoTp3dtaAQxexPnGU6/bBNEOdX/4GGWmhvgeDOTtTIo
 uWmNQvFLziybHm9HPQnYv9cd2mP99N8=
X-Proofpoint-GUID: Ayy_DRrhJz4erGJBW5Ht6QSlGdLttnnv
X-Proofpoint-ORIG-GUID: Ayy_DRrhJz4erGJBW5Ht6QSlGdLttnnv
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a589e39 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=fqn4YNmA52JUfYToRRoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091

struct drm_simple_display_pipe was meant to simplify simple DRM
drivers, but instead adds an extra wrapper around normal DRM atomic
helper setup. As noted in Documentation/gpu/todo.rst, remaining users
should be converted to regular atomic helpers and stop depending on the
simple-KMS interfaces.

This series converts the following drivers:

  - arcpgu
  - aspeed
  - mcde
  - pl111
  - gm12u320
  - repaper
  - tve200
  - xen frontend

Each patch replaces drm_simple_display_pipe_init() with explicit
primary plane, CRTC and encoder setup, and moves the old simple-pipe
callbacks into regular plane and CRTC helper callbacks named according
to local driver conventions.

The conversions preserve helper behavior that used to be implicit in
drm_simple_kms_helper.c, including plane-state validation, CRTC
primary-plane checks, affected-plane propagation, framebuffer prepare
handling, and existing event/vblank flow where applicable.

Result is less helper indirection and more explicit driver-side atomic
wiring, with no remaining simple-KMS dependency in these drivers.

Except for gm12u320, no hardware testing was performed.

This series is based on drm-next-2026-06-27.

AI usage disclosure:
- I wrote the first two commits myself. The remaining patches were completed
  with assistance from AI tools.
- AI tools were also used to review the code and suggest code changes for
  the DRM atomic conversion.

Thanks,
Ze Huang

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
Changes in v2:
- common changes:
- create upcast helpers
- use 'commit' as name of struct drm_atomic_commit in atomic helpers
- improve control flow in *_crtc_helper_atomic_check() and
  *_plane_helper_atomic_check()
- Moved page-flip/vblank event handling out of plane update paths and into
  CRTC atomic_flush(), using atomic_flush and disable paths for mcde,
  pl111 and tve200
- arcpgu:
    - remove reduntant mod_supported helper
    - change obsolete mode field to crtc->state->mode
- mcde:
    - drop attach of unused encoder
- tve200:
    - reorder connector/bridge attach
- xen:
    - change possible_crtcs mask to 0
- Link to v1: https://patch.msgid.link/20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com

---
Ze Huang (8):
      drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/aspeed: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/mcde: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/pl111: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/repaper: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/tve200: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/xen: replace struct drm_simple_display_pipe with regular atomic helpers

 drivers/gpu/drm/aspeed/aspeed_gfx.h      |  11 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 187 ++++++++++++++++-------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
 drivers/gpu/drm/mcde/mcde_display.c      | 251 ++++++++++++++++++++-----------
 drivers/gpu/drm/mcde/mcde_drm.h          |   8 +-
 drivers/gpu/drm/mcde/mcde_drv.c          |   8 +-
 drivers/gpu/drm/pl111/pl111_display.c    | 202 ++++++++++++++++++-------
 drivers/gpu/drm/pl111/pl111_drm.h        |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c        |   3 +-
 drivers/gpu/drm/tiny/arcpgu.c            | 179 ++++++++++++++++------
 drivers/gpu/drm/tiny/gm12u320.c          | 132 +++++++++++++---
 drivers/gpu/drm/tiny/repaper.c           | 132 ++++++++++++----
 drivers/gpu/drm/tve200/tve200_display.c  | 217 +++++++++++++++++---------
 drivers/gpu/drm/tve200/tve200_drm.h      |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c      |  12 +-
 drivers/gpu/drm/xen/xen_drm_front.h      |   6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c  | 175 +++++++++++++++------
 17 files changed, 1107 insertions(+), 430 deletions(-)
---
base-commit: 3696d07837d1df13a5603d77f667685e7dfb3c53
change-id: 20260704-drm-simple-kms-removal-01a031c6a129

Best regards,
-- 
Ze Huang <ze.huang@oss.qualcomm.com>


