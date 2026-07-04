Return-Path: <linux-aspeed+bounces-4343-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B5C43458
	for <linux-aspeed@archiver.kernel.org>; Sun,  5 Jul 2026 05:29:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtGJM3jzRz2yYf;
	Sun, 05 Jul 2026 15:29:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783189963;
	cv=none; b=oZrvhSqX2e6HBUFfrvBvrQbwZ+6s4HlP5bYi+ZpdXwQFdyZ3cSG0rVxc1zEegUXXzi8QGgJxPIVOvLLlkf/KukzZUmoZ0nZrNA0hrKN0kzzU7T7tKl/jJPv/vssKsqr0QiqebMreJCivKXKnOdwBpa/3U5USbboSFla+XpuJIwIc6fPEd3DrBCmf1eezo2R80/LGG0X4EpcW7BnQB/bCAXGRkzk+5nhnUZ4d9xN8I4w2kJubOq722RgUPDrptpdUxGd7uBz19KyeZUspIGrHcx31DqoALAVLlGq/kNDlN4ASu4jXb+Re53m6vdr58qGs8sx5k3enu/WChf2z1fMLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783189963; c=relaxed/relaxed;
	bh=MltfzpfpaLuZDnkNZx+Lb6VWJ4GPL8eKrD3GSx0ATGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XdE3hmfCwHRW2r6p98Xqq+K+0/Yc7C/PEj01rSe0m7QZ8Xdf+qc1XKDvKZ2uKC9LCOLXjYHo2HTzOQ2sdL1THd9BqhHCy84caZtzU4qmJ4qz+rTspIJ4Qw1nglJUPHTo2whhaUGkxCtDqVhfZXOKKKFj4UBKIfoXJBlzHKRczuk5fI4kbZqsLOYJWiYjMPHKDKHoUZzgpr7alTtQsrePAFLz3Rsgr8Kl7gEP77prZ5HaeEDV3x1o2qXe95boKwNAF5heHZ2Yxh/8az2oQcb0vG1xpLtCuXFTW7h11dyE8xR50+lPkYTAvt0Uoth2N4+4aliwyPf7mAcjPNKxSFxUrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CSEUNTWN; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CxxR4NvY; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CSEUNTWN;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CxxR4NvY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gszkd2PQDz2xyh
	for <linux-aspeed@lists.ozlabs.org>; Sun, 05 Jul 2026 04:32:38 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 664G8gxu3432908
	for <linux-aspeed@lists.ozlabs.org>; Sat, 4 Jul 2026 18:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MltfzpfpaLuZDnkNZx+Lb6
	VWJ4GPL8eKrD3GSx0ATGM=; b=CSEUNTWN1DlO1mccs9tBOSMPvsm87QKPUuehKQ
	4K6kTjt1FKnv2ec0M8Ysv/X+5cdqXiRHqij/ORCYEDmUr+Lvfqi2Bb10tvUqlWYK
	6bUxEtHDeSVXR1YlKacaMujOYA044wSdNr9b9B9nlb84ycDuDYWoCL+A2qahMRDh
	QaXY3ntdMFBxDIr+RrCRCbj6/BLG0BZQLRU8QJzw6wEZsRPcqLF+9/q4Kr6AjCvh
	6HdIKJwHHUAO8X324yL3sIeCAbzFf/FbdmaEFj/XSnPAux4wnR7Iw7HkLjguUK31
	c2tOSjRDtb3pqINNlxcgrFkpU1+GI/Hxp75MpAT7pOVePlMQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvhdj1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 18:32:34 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847a5f03ff9so2433596b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 04 Jul 2026 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783189954; x=1783794754; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MltfzpfpaLuZDnkNZx+Lb6VWJ4GPL8eKrD3GSx0ATGM=;
        b=CxxR4NvYxzarAjYwcpdA0F94x+RmVO9IsxHZk9f9jj25ty9+yIn737rw0sMQpGtwVV
         eG8B2a0aw33fzHsq5QFZpuoeoPch37KbX6nLnXDXI3ETVig6EteUsrMPhf+kVQ0p6381
         3w54niYNeYhrM6hFx/h8V3zbLdemhrTueZ4HglPVpI1RkCKySpprEnUn8bWE9udJYBD1
         fTNq+O6TNFizbI/xKzGt074+FioJCd5ikUMrIvtP4sgmcpUPYzOh52YtNTtaNo34IwqZ
         CbN/ORKYy2Sj8pIumArUbp8rtL+Rm+N2qdd4HqpaFIZVbqPCCKKT/Uwoy3kyeZFWO0c9
         ZZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783189954; x=1783794754;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MltfzpfpaLuZDnkNZx+Lb6VWJ4GPL8eKrD3GSx0ATGM=;
        b=E8YAC+dbVMM+2IS6BJp+LZ1BanwP4E7mxK/T8Wi8bEu70tuuFiyYwFNc3AI4A8QN1s
         7GrfuMl2KZpNXA+xf6vpLlVr2rVDuegFNcsBrtyZZxh7mGCQikg5J9l8uqy91ksfwJGW
         Yvnls/gc5QPHj0FNXI7NE6j0RN1mTb4IoK3DIjrGzcL5c4pQx2NQyBovJZOKD8OPTwst
         9F+xbucdslvuMi931bS2F9BpESONfnH2sDcAWS3tjtRA3JABrmiS22NITMgDjUNQ3Akd
         zREncrplGqrZ//1m4SQm31sKkN4OHsQARIV7N71KYpP8Hv5CLyfrAaDq2XB/cNx87/0J
         C2GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8g/DeIiArkdb5qwQrIO5gJDc2G2+XbYh/jDIz7MaZNwG16tvpekloXbBMzDXexud3PL+0WbGEVreMpDao=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyAAwFOqCGQPBFZCfRCXKlJBfrDTWwm3K+8r/LOgemXipiANcd7
	PMubkL4gcadlkJsxG992mmywc3wurLq9o+glSPf76tfqEpf/SU95wCWYu1o9C5UtHwceCiT2BJ8
	MszVnvysEw77uoBQ0hfLb0xmtTRpWDjYnFqszijnQCnjufZS0QlpYvePz4VbC26CHSgwZ
X-Gm-Gg: AfdE7ck74ehUSnZRR2NL9BWrT2DrL9U9VhT3Nxb0pWhmC/YCfclGeHOfoumHACstJ/s
	YDEyVFntltKiVkghSAWCRodB3ozbr1MGyCuKSyJRMG5uo7L4cmzkUO1xySU2dG/Q9rUxXEDtls3
	hpjY/BUkQD9oxEZhEzmy7u9aIWO3i9XABAod7U0aAb559fXrcZRxqVQ7fskimZaStVPeB02Bgd3
	9K24QzL/aeiKwoYlN1Xv60P9qbnnSFiAl6W4z21mE7g4o+AHyVPvCf3Di4+o6EBUnSDDLZT+Fvp
	RHYUP6E7dwexytCmMPOXZ6IM0a1e+NYjXbxlBm0mAh52Lhg+FQzSqtBql8M/xvj6GAPp1NZj0gi
	o+k8ESawrzcDZvvRzNVZOZpg=
X-Received: by 2002:a05:6a00:1881:b0:845:ebbf:e7be with SMTP id d2e1a72fcca58-847f6dd3dd7mr3575643b3a.23.1783189953620;
        Sat, 04 Jul 2026 11:32:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:1881:b0:845:ebbf:e7be with SMTP id d2e1a72fcca58-847f6dd3dd7mr3575622b3a.23.1783189953074;
        Sat, 04 Jul 2026 11:32:33 -0700 (PDT)
Received: from [192.168.1.100] ([151.243.38.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b6057dsm1508437b3a.7.2026.07.04.11.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 11:32:31 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: [PATCH 0/9] drm: replace simple display pipe users with atomic
 helpers
Date: Sun, 05 Jul 2026 02:31:09 +0800
Message-Id: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBBFr0Jm7SRtNRC5imFRyqijFLBTCAnh7
 rbi8iX/v7eBUGASqIsNAi0sPA4J9KkA97TDg5C7xGCUKVWlLtgFj8J+6gnfXjCQHxfbo9JWnbU
 rrTZXSOcp0J3Xn/jWHCxz+yIXs+2/CPSZUzEeM2itELrRe451kTsDrRFzGVWJpoJm37+GdJ5Cs
 QAAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783189912; l=3497;
 i=ze.huang@oss.qualcomm.com; s=20260704; h=from:subject:message-id;
 bh=a3oJlDmIy4JLxHP8+Zy827sxSxkG1qtSrEiIUv8u7fM=;
 b=oTFO2p3qM2CB2fGh5FbCqHWfsLjAUpA01rJUrP5DdH2raMv7Em7rY0rPoVQz7ExoGxuGHOYTD
 NpzXPoGsHqtBE5XHc7JyEmeSHN8I2421kM7XwjgHHvZaekp39t8rsAh
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=pSsISLZF2ubEjJRmslsa6Ps4W3yAuPY7yaircQTlQQU=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4951c2 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=cNux22OjBTKCC6TmznXXXA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=mcgfQexBA9BlAWrkqKUA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: RtZwVDJtUr6_UggNr65xKVven0MXEFWy
X-Proofpoint-GUID: RtZwVDJtUr6_UggNr65xKVven0MXEFWy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfX/5rsI82nFPJb
 MTcDMYsgn3z3tCAsfePaKG+nDu3wn+NwGfzMhicdQwl9MffoqMNb5MzA0jYfulVwDu6+LrFOLov
 d0xu9K4um2pWdzS3wqhBrZ9gDcIvliwqGWKkTNW5e77rg2dCN4nkJqIUZ8P7wHPhnjPzWOd9qwL
 m6ObdURQtUiJjMNOjWafmIJojJ0faAQDj49nfsvmgNyEHSmd1RYG6neQV+gYUue3UMXOO73yitb
 T/zECaOjPQw2xCUsake0mGTwjyEdc3IMbQjvy8shYbtQ9mhz9+3+gcWjhUYGPsC0lv1BO/s4Obl
 UA7WQ0ruWKX5dc2n7fLpkT0oi+mkzVQoyqGWu84fgfHtiwjXNerte5Y6Gq9qMGbVt9JF4OrgweA
 6SlygMTUWhcS7hSlQmkOyhfYL1Yj8HYn6ZjNi8qfCZWLGUQLRghW2EzUVzd4byMkbUHlpGnmvXa
 7anKsZcBmQg5aWyV0Ww==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDE5MiBTYWx0ZWRfXzyjeoCGU4SyX
 3pme7rC1f2lzOmQpmgpVXpIhojyxCPe7KrTMqIfQVWZa9ryJvPD4qdmNnUuoMW8ScHG3pB9UYeh
 XperwwWtoAB0/caJhbD605g0RL8ZGzI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040192

struct drm_simple_display_pipe was meant to simplify simple DRM
drivers, but instead adds an extra wrapper around normal DRM atomic
helper setup. As noted in Documentation/gpu/todo.rst, remaining users
should be converted to regular atomic helpers and stop depending on the
simple-KMS interfaces.

This series converts the following drivers:

  - arcpgu
  - aspeed
  - imx lcdc
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

These changes are build-tested only. No hardware testing has been
performed on the affected devices.

This series is based on drm-next-2026-06-27.

Thanks,
Ze Huang

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
Ze Huang (9):
      drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/aspeed: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/imx: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/mcde: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/pl111: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/repaper: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/tve200: replace struct drm_simple_display_pipe with regular atomic helpers
      drm/xen: replace struct drm_simple_display_pipe with regular atomic helpers

 drivers/gpu/drm/aspeed/aspeed_gfx.h      |   5 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 156 ++++++++++++++++------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
 drivers/gpu/drm/imx/lcdc/imx-lcdc.c      | 178 ++++++++++++++++++-------
 drivers/gpu/drm/mcde/mcde_display.c      | 162 ++++++++++++++++------
 drivers/gpu/drm/mcde/mcde_drm.h          |   6 +-
 drivers/gpu/drm/mcde/mcde_drv.c          |   3 +-
 drivers/gpu/drm/pl111/pl111_display.c    | 174 ++++++++++++++++++------
 drivers/gpu/drm/pl111/pl111_drm.h        |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c        |   3 +-
 drivers/gpu/drm/tiny/arcpgu.c            | 165 ++++++++++++++++++-----
 drivers/gpu/drm/tiny/gm12u320.c          | 128 ++++++++++++++----
 drivers/gpu/drm/tiny/repaper.c           | 130 ++++++++++++++----
 drivers/gpu/drm/tve200/tve200_display.c  | 221 +++++++++++++++++++++----------
 drivers/gpu/drm/tve200/tve200_drm.h      |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c      |  17 ++-
 drivers/gpu/drm/xen/xen_drm_front.h      |   6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c  | 177 +++++++++++++++++++------
 18 files changed, 1164 insertions(+), 381 deletions(-)
---
base-commit: 3696d07837d1df13a5603d77f667685e7dfb3c53
change-id: 20260704-drm-simple-kms-removal-01a031c6a129

Best regards,
--  
Ze Huang <ze.huang@oss.qualcomm.com>


