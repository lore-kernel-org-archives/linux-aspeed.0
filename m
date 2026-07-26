Return-Path: <linux-aspeed+bounces-4564-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D2FC53219
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f6r19nxz2ygK;
	Mon, 27 Jul 2026 10:07:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095142;
	cv=none; b=LaDUo//iXS+Np8FKN8O5CmEn8lLx/vwawGaBXWmCfeDdP9Q3UYLnZGmK+mSAWOkUF/Eq+6jcS7yt+TLcyQ2x1w2J1tiReFuLnJdtshYvYaC2YEDiRJmT+fVeXTT8E+PjYFLn470ECn76A+Q1vQ92qVpcZvwlSWONrvs29fUm0+hsFkUOGEWAtindgKDYJWA8dKlvni6GQmTCNsO1uZkIOtXb4MwD7e51Ig8FwdR1psvGKlSg45IY53AFnbm0c1ifnWWvrxwEjHu7UtLhWhV4Hdo2l027IIyJtrf34FQR7w+GPzBTmapW0g1/EowTcLC1HJPewieaOBCX74S80nzmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095142; c=relaxed/relaxed;
	bh=0ajHIxefN4bg3/NHnVq4I6V3IZtJtWB7vSvRVCv6OFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ftxfKpI81A/brf5g5tqgyxCKV7It5a+uu7zLP1KfOrqOkwk4Y/CXsAKlZXn3aBgfUdg6VMD0JrpzhC2dAM0DnOdYmpMg5k93t227TbOedvzzNCWFJo0BphSudJlmknrc/Ejdxcb87pQYTEY3xAJzhrfIj9tqRPHahlfrmkuL0LEvJ/6x8zwvT8vP79rbdZHvRL/J6rPnqeaRO+QxljIw6D1JrOEAWom6xFwq747uFS2TkwZLa/Fbvd+JAK9/3a22sAz6T6Guna+mUXC2jMUF9IdOGrKg6636L+h6Iyr6251Fze4GH4fgixkNcbcuAr3yQbyDjrvucKTyUnq9X4cSYg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gqepHiM+; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UemjPoaz; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gqepHiM+;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UemjPoaz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XJj3bKnz2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:45:40 +1000 (AEST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH7BQf1371451
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0ajHIxefN4bg3/NHnVq4I6
	V3IZtJtWB7vSvRVCv6OFg=; b=gqepHiM+WpEKBlSCQThncb9R3/gVRYZO040V+o
	sE3PF0NuXELd2wESCl8B3OfxzuLlatHm14QkBSXAjzyjKMiOXNkpAMJrm+bT0ZJK
	f19mpJyfWxA27aIdH6Q3eI0R6rP6O/3Ij8qKzxPEE3CzJEaqxhG9CkllwsgGqHGI
	HMVq3Va4viF79Ype5Dc9cWRgl/4Q1TaCZRlK0yPy68tHcuvIZF0cTmZLKd4iooFE
	DeT1j8UAGNjfrTlK7ajewKz7zqXnlHow3cRH7X+IOD1r4SdOWXCBdflbFRF+j+4W
	6UkzeFwJeyein3cGOkQYR6BehZkelUfQSo0hVIKYY7DkmxuA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fngysrsse-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:45:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so3061449a91.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095138; x=1785699938; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0ajHIxefN4bg3/NHnVq4I6V3IZtJtWB7vSvRVCv6OFg=;
        b=UemjPoazsC+1WtlQNGDYM8aty3wmSkgDt7CMR+IlqgKzy5dEz4A4aTkLOUJtvkeRQa
         wu7VO0wNnPW9CtCR2k8q8XvauQiYGt3KU4U8NEyfV+XGINrqg8fVB1fZL+xQzhii/NZX
         VfDuiM/OYpPZGdpdP/wBfuynOv6BaFZdsvSjf8luT3RzjPUrjwL/oMKiAUgV/oKb6xYf
         yOd4YBk4d5gY1dl4NeBdk2cyKHxG5Ba9AoNMFlcM1QKVH9GnFaeJKnZEFgycOjOQ6KNg
         2NUZReJGV18hJHkHlda4MmkCA3AgW/VK4zqRuR02+/BfZkgj2xY/RBjNRIM3jFpJLO/u
         RV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095138; x=1785699938;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0ajHIxefN4bg3/NHnVq4I6V3IZtJtWB7vSvRVCv6OFg=;
        b=GUKyCHKdxsAmibjvwmJ2+HUrWwYpr/9x9hJYEL8K5mNOY9TXlSxnmYsMMW5xNbhh9x
         qk10BEac5qI38Wr5HY371Rf7GKvDCLiQLG73JifphNQA+hx+BqhDTgq7V2FNFD6ly57/
         e8NPFwITdsOBPU5WxaH4x0NEy+SyZG3iZy9TIINWn1ryZkWZ1XkFX8FDHFXV1cIrRah2
         eJAfh+DPYLSkiuRP2wIyjKitdCv0LoqKET5moFgLF3jNyWO15Gq8ZfQ5RT0Yq+XMxKUw
         EaTC6RGM28SWIrV6p9ukX9S4pbW4muvMmCZKcdwXaQOqAr8BLERQpPKf/P7nXDInQ/ls
         Tn0A==
X-Forwarded-Encrypted: i=1; AHgh+Ro1Sn5c9VKkxHPPLh+lYMscO0vekOnJttFnzTwb8PpMvGwfk6k+XeGt98YtL3+ix1lhURw4482momaR18k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw79p3StKmJDH6CiNyVcnhRc9rNUGpQ82VJNeoDBUYcr+jX6rZ4
	z5SIYh3Sax+6uAaJO/gAeI6VrU3MP0142Yrn0i5n92tOLvUsoIO3Dh4G4D3Ir3qu7nP9ydEPwoR
	U3AFLAnrKOdEV0yr0g79ao6mKUmS/en9ySmGWYVzAr4bC5qrJiXajRibU7HvaUnG4QTB3
X-Gm-Gg: AR+sD102hJX1UywBZI+7oEL3pR9A/w0WnRyFVz8CQjX8XBgHLMTFL84CnQxLLqWl43H
	rFfbbgH+8H5+qZUogIcAMAYn/cNIQ04Ey1venjEHuDmoP+GuLPrazN3Cw7+CcmvhBZcUpiWQxbA
	rCaq9JOv8MF2kkhJ2T1bVkYZHQNNbWNXTRgKxw0Zd9rnyW+L47xE7UdqZZjytEq0J9KwWlL4qMI
	n4AzMP1hnZcJqRxsqcdNJqmsxh14uVUsYApJLpFr8KxWrkm1ijuAP2iYCyj9hBbdqGcLhbsESYp
	TbITH4LmbhejttPgOmiXhYq50A5XsIHHVIBJ7Bqt9wLJwZm8uu/t8mRpUhRdJ1qPvLMAGPtnhzX
	9KR96UCOa+6DQCj7hxSjZ
X-Received: by 2002:a17:90b:2dc5:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-38f2950e5b0mr5850187a91.15.1785095137764;
        Sun, 26 Jul 2026 12:45:37 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc5:b0:38d:e0c4:c955 with SMTP id 98e67ed59e1d1-38f2950e5b0mr5850172a91.15.1785095137330;
        Sun, 26 Jul 2026 12:45:37 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03b0eaa8sm4105998a91.8.2026.07.26.12.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:45:36 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: [PATCH v3 0/8] drm: replace simple display pipe users with atomic
 helpers
Date: Mon, 27 Jul 2026 03:45:13 +0800
Message-Id: <20260727-drm-simple-kms-removal-v3-0-cd5dc89858c6@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMtjZmoC/3WOy27CMBBFfyXymkF+EAdY9T+qLhwzFEMcg8exq
 FD+vXZg0UXZjHSluefcByOMDontmweLmB25MJagVg2zJzN+I7hDyUxyqXnHN3CIHsj564Bw8QQ
 RfchmAC4MV8JqI+SOlfI14tHdF/Dn1zPT1J/Rpkp7fUS8TcWYnm+sN4Rgg/cu7ZvqGfGeoJqBa
 5Adq6CToxTizzI4i6X32ta+25YFcOg3KKzhrdJSfQSi9W0yQ5Wty1nIWf6hCf2WJgtNCKXM9mh
 Vt23/oc3z/AthEOIdWgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095128; l=5032;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=M/SBdA7VDjpMs5FPTVXoEwvZ9jXN7FwKp4wRYNhbi8s=;
 b=vdmSVBLYyiSgCzw5y+D627tBad3p1KzqzB30cNZzauX8H/pqI7pNd3FVlHJnpB9kKpf18kN88
 Jj8375htkKRDUvCLX1+Z4CLbQnTHMi4DVNy4Jk0ylOpVkfagdrVuj1K
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX4ve55F8VoMj5
 f/rRQDRjw0Falflya2IGIYkJpWGuCDFpt0UzgfYue1VjSNlJNmVnVPonLtRVolSCy67LrpG2JFp
 aEb9nKmjLc3iCqb60BXQVd1eyY5yFJxSyKYWyWTKn422ojTTW56/XYQg61stgOSUJiS0vA1ueka
 OTMsyTuYtWb+D96BvNg4uJWxHHqSar9GdhrqBax5UZHsfuvMglYMscbS2628zNB/g6mgtg+Se7+
 Ap+tHUnMPIBCLoJt8PIaZ8T6CR8rrXrUVqJxg7UpPB7Lv4sUCyq9d+sCEcuG5VivYeEzkhlPO0L
 xvdretJnCMWteIbRh4OSbEMEmLhGR8WuoBBHZnJhZDAoQhj0HSDfhIDh4565WYjznnhn1JsNWm5
 Qr0H8Wqv+ctWqD3ox/qaUuuY/LiK+RMtBky09Z/iXGXsWPvZtMTLwHBSUx6oqXvkaq+E3oX/JeL
 2BCe/55LsLiBzHAAYyA==
X-Proofpoint-GUID: 42_t9TKr_ZrYahnXatdmmMj5JKrft7K4
X-Authority-Analysis: v=2.4 cv=DNG/JSNb c=1 sm=1 tr=0 ts=6a6663e2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=0c0Jg-khWEd_mnVUI7kA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX4wlH6b4SUdo0
 /ZOofINdfgM3DaTNBZXQoAHJkRUp70U4G8rOl/sTX/TXppCQo3jDCqo10tylQrCZUbxXXdBHifh
 /BKJYG/iqdT120ZYqPZsYlaX+7kfRIc=
X-Proofpoint-ORIG-GUID: 42_t9TKr_ZrYahnXatdmmMj5JKrft7K4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260200

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
Changes in v3:
- Use atomic state from the commit path consistently in converted helpers:
  fetch new CRTC/plane state from the commit in enable/update/flush paths, and
  use drm_atomic_get_crtc_state() with PTR_ERR() handling in plane atomic_check
  hooks before drm_atomic_helper_check_plane_state().
- Move MCDE one-shot flow start from plane atomic_update() to CRTC
  atomic_flush(), after pending vblank event handling.
- Fix repaper damage update path to skip updates unless CRTC is active.
- Fix arcpgu missing remote encoder node handling and lock CRTC state access in
  debugfs.
- Make container helpers static inline.
- Link to v2: https://lore.kernel.org/r/20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com

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
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 203 ++++++++++++++++++-------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
 drivers/gpu/drm/mcde/mcde_display.c      | 248 ++++++++++++++++++++-----------
 drivers/gpu/drm/mcde/mcde_drm.h          |  12 +-
 drivers/gpu/drm/mcde/mcde_drv.c          |   3 +-
 drivers/gpu/drm/pl111/pl111_display.c    | 199 ++++++++++++++++++-------
 drivers/gpu/drm/pl111/pl111_drm.h        |   5 +-
 drivers/gpu/drm/pl111/pl111_drv.c        |   3 +-
 drivers/gpu/drm/tiny/arcpgu.c            | 201 +++++++++++++++++++------
 drivers/gpu/drm/tiny/gm12u320.c          | 138 +++++++++++++----
 drivers/gpu/drm/tiny/repaper.c           | 138 +++++++++++++----
 drivers/gpu/drm/tve200/tve200_display.c  | 219 ++++++++++++++++++---------
 drivers/gpu/drm/tve200/tve200_drm.h      |   6 +-
 drivers/gpu/drm/tve200/tve200_drv.c      |  12 +-
 drivers/gpu/drm/xen/xen_drm_front.h      |   6 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c  | 188 ++++++++++++++++-------
 17 files changed, 1155 insertions(+), 440 deletions(-)
---
base-commit: 3696d07837d1df13a5603d77f667685e7dfb3c53
change-id: 20260704-drm-simple-kms-removal-01a031c6a129

Best regards,
-- 
Ze Huang <ze.huang@oss.qualcomm.com>


