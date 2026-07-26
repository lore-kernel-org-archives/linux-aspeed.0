Return-Path: <linux-aspeed+bounces-4567-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C6BC53209
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 00:07:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7f7271HJz2ydn;
	Mon, 27 Jul 2026 10:07:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785095023;
	cv=none; b=M6SwgSOC+zmrso+4KWtOk3CSgll4kEHrgXywyvniZdurVV3TVToTI+CPg4POb482Y2UKe4QE3nhDoJKN0GsQibhYEKNCr9rU5WdDH6zizQ7lfIrI0z+wp4bG46CqK/ZhL6xyWKrba9t8+MHZILNHOaw6MNfVfsrzzAvi8SG9+7X+O28CLWC+c+2dsB0Etgrh7KAGbUKh96NHCfc3XfDAew67A9dct9DXZhKJwz1A32o5tJW29/EEJDc6sBl4aDC20URvz76qF9+PB+96B/1RZR6ikVjo9tSIM55SgBUptTlyYkkg/KqvPUi5bAp1MAjK2djzZR9QLibRME6gFs7msA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785095023; c=relaxed/relaxed;
	bh=FDQIeXpPD+dwLpKCV5Porvy3ne6CU+pJakDyD+AScDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N06lR4t6/iAxfonZCp9NvlzF+WV7s+GNQSUkV9MBEC5KwoAD1aqx9tZsALjxvATihbGrulR6wWaFCb81yXx1wWWcIeUjDGcasaIUfANR/IBH/U3TZhVI5Z4pW/ItEhJlRr6GcMkmIC5ubmdraASSsYD8RRJf+zcEa+X4r2b1X5SQ8T5ExLEc+sFwK0GWWwQw4LYwVxdqBPHP+qQrlA0B8CdtWUzLhl0GT3AJWgo6eWbENU5ANVxvQTmBGcxXRQ8iIMnZFG1a6NB9RUKXoEHPWND+RzyGvvb5C6bspyGrKU/aSabIlNBcJazTupe+PJn5a8zpgS+W47jcD7UOGC9ONQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pAZEOG1U; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SLdrKhHs; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pAZEOG1U;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SLdrKhHs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7XGP1CQ5z2xWY
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 05:43:38 +1000 (AEST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66QH6ibS1522888
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FDQIeXpPD+dwLpKCV5Porv
	y3ne6CU+pJakDyD+AScDY=; b=pAZEOG1UWrwTp6+Udv9XpGfugtOEAbIEc8xh32
	izDKpGGoq0uH1WZWcQJmbJh+NgBE/f+Uy+hkdw7i28QDjdp4ViKCyfkO6VwS31Rf
	mPq41EFbFh3JI6QUTWEmXHsgHUGiynrS2EXPL8ZkcGbth9TSJM0wOlwvSBZpQM8B
	S9RjIOpjJQY3oPTTWsdlHzfSuVc90CxICcka85UZSEoOl5LywkG8t9kdG5gFsMwx
	lewic+xOYkv8Oo6dLPBQixW7/Z3DgUgfa8U0YswMXMz76jIhiG6QgcCMmaHZOpAh
	3/lvfjR7c+MmmS1k1XWZ+opI3fWzDVLKNYC2G95V8q3IShMg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm3sbnxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 19:43:34 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cb835525b10so2464653a12.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785095014; x=1785699814; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FDQIeXpPD+dwLpKCV5Porvy3ne6CU+pJakDyD+AScDY=;
        b=SLdrKhHs8ET/dXl0Gk24TNt7Jbg5HIS1rzmyGpllR25DOMExp39HvYp+Op85dvInBR
         qY117rFaGkzFEII95L8UAp1KlhtNXEAGvCHUmwZfihCaDLfsM7XqS51gMMFVzDpwPe69
         Mln0FynGtSkrLSr64e2EcroE9SCuDGd/RqESKKgydmgYAVfjiW2/1cscr9fkuSS2Rd58
         WmYzJFRillzfvDwRQHCimE7QUzWHoT0CjbpghQ5iucAKmMv7IUBFNRklyD+4lsmfkO45
         UyhQVwVX6aMhgG8ndL6MvL9eTuN5kRrwK75JRWs722fDK2cP50B1CZpUy0loLYxInlSW
         hmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785095014; x=1785699814;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FDQIeXpPD+dwLpKCV5Porvy3ne6CU+pJakDyD+AScDY=;
        b=kFeX738aOmNGP9BmHTmNPh2IvIAU/7n/j18EVyOQplt0RWTey9+rYeu2rgNPBA2ZAd
         wG978rCQUYQMCszLbVodfExFHK2mTPhVbL4pIL4cWrooeeFdi0AGGPK0Bj2nD14jmELm
         qWsrSGIrNhPB0/dCQPqqMSm1feIURvRpXDnd7f71W1g+piOJnK8airw8/+9sFXtTofzy
         Uldm7/77uad+qbWX/d/MyhgzMqG0HanPi8WIBRN3UndsPVY9+N9a0lj/T0imfOtnE0Og
         /Yp8zRVnKYtpOmSGwpgtRGvSo1BufG2/18pPBXxp5WAdHwqFm1pkgSmQwQmBeUFtF/v8
         lYqg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5oPdP4g+SJDQYVoK4iffJiJchT37t9wlsU2BFxuUMdwaFEkCmI+LtyWFRKbHb7ePk0wQ6g5o35VlGmCo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YziRjDJnEuOK6SQgrNS63OHfwjYM6/ygCYVpm+SC3599n6UTBst
	L7RF/loVgz4gCLFJgNmw5T9fL53HWpD/prgd9EQ7Qd6eSRq4wE7RjkTFhEyenEJB+NbDEOY2VAG
	MucRD59U/Smjkrn9znbuiUEnxCrLJAzkVe2Xj5J9DaeI15/hEFGhRfKtHgRMdzxHN7Kid
X-Gm-Gg: AR+sD11tX8PgklnhAnyH8ydolqFXmNbYtVl3aStnPCRh/t1Qf0gyM5wODBEBgnRrH92
	qA3r9P2VwC1tXNcvHu5lhjK+IvGdH+AOHweTjiZlifAQen/cIEWjV3E0uuSvu+av5WFBMTZtkUE
	jQ5dkLrymA8Ki8UwWnOJJNJQTjlTV7RiXhEXWEAeSaArN8ShiIgbtSQ+dzDbL/QfapYms4IzJKx
	6W5pRv9CizwujgRzG+w+JMpEQifNOCwTbYJvV6wZdst/QsmAQ35P6dHp8bPERX8FJ1M+it6W3Zj
	+c9dO6hSXsfU1omZMTIMaaLI3Oy9iQ9N/utNW1X9ijr9ZtYkZXyM92CZ22iDRilHMHtVuEJE/Lu
	i5lWKQcOZ8UCHR33nnh2O
X-Received: by 2002:a05:6a20:43ac:b0:3b3:2703:115 with SMTP id adf61e73a8af0-3c67dc41ae3mr5548171637.16.1785095014256;
        Sun, 26 Jul 2026 12:43:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:43ac:b0:3b3:2703:115 with SMTP id adf61e73a8af0-3c67dc41ae3mr5548148637.16.1785095013838;
        Sun, 26 Jul 2026 12:43:33 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb66dcd38sm2312070a12.29.2026.07.26.12.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 12:43:32 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: [PATCH v3 0/2] drm: replace simple display pipe users with atomic
 helpers
Date: Mon, 27 Jul 2026 03:42:31 +0800
Message-Id: <20260727-drm-simple-kms-removal-v3-0-de36e534f7a1@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAChjZmoC/3WOwQ6CMBBEf4Xs2SVtEYye/A/jodRVq5RitxCN4
 d9t0auXSSaZmTdvYAqWGHbFGwJNlq3vk6lWBZir7i+E9pQ8KKEasRFrPAWHbN3QEd4dYyDnJ92
 hkFpU0jRaqi2k8hDobJ/L8OH49Ty2NzIxr/0SgR5jIsZvDFrNhMY7Z+OuyJyenhEzGUWDagN56
 Go5+vBaDk9y6f2+1f++TRIFtmuSRou6alS198zlY9RdhpVJ4DjP8wccL41iDAEAAA==
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
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Marian Cichy <m.cichy@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, xen-devel@lists.xenproject.org,
        Ze Huang <ze.huang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785095005; l=2679;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=SzrRHowXSa10BAHCyJ1LhewVqZLaXZNB44vA3ptkLd8=;
 b=ygG0jOkfjjtOnpnb/85WRy8PlT/tiW1jcovVo98E9rFl6SsoVZpL7kFNMISeo+OC86QqJ04Aw
 LK0RRwuDsgNBhR/dSZRqnbW+r+gFyurTl3vHzvkgzWB3HgUd6B0UHHR
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX/KlTsXuaeFaB
 b+swPLgC1Wx/00UELwmIpHQZJ8xkMY993DfCxgCX/WOyMPOtCkoGWQiLLwfy4/xHXC/tZ0aA9PL
 ZPhyeyNwUmAu3NL1I3GEVQJmm2x/0jB4SvhLcxjv3f/3NXOVGQ7jZ0tVxiwQCNoV14lm7YIgY6/
 O9OcHPf3WHNvad8LFLrrDfENZJSbiiHWjT/fMzEZ2UEkVj0j+EWaoz18ZaW7SWu151mgkbjNyuT
 roqSsff/RjRelvDmbCXmapeA2U24M49+LehIJgUuLc1q4TjlsY1DjxgqqFpAn3mPlg9pvSI9ywz
 qRVBQ1oINzp5oRq9Xc/RPt4h1wnv7YX+waeYI3FX5VPOBOnwuvFEUqEF6hUl2dUIZenhIdODGct
 Rimwu9jHxQgOECxwp25DNsSBk6ENJPWUoGKRRW6Xa+tNwin7fLKzpHQ6GF+/jMcYwDkoezabNwg
 BeLHMIQAVmqeVyV3CPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDIwMCBTYWx0ZWRfX1CU1IpNDrHmp
 Ae46eLisp9sJoyeFa5/IogFAKTIFzixSJ7C8DEVjSuLBI038DDjZLvb6ncaMFIKOPFpW1CPwYPj
 dote1pjJSKlTxohAY2cAgC0UNKXfPfY=
X-Proofpoint-ORIG-GUID: BjiyANOq9w7K-ScDVNlbbwphLhNe9HuU
X-Proofpoint-GUID: BjiyANOq9w7K-ScDVNlbbwphLhNe9HuU
X-Authority-Analysis: v=2.4 cv=KanidwYD c=1 sm=1 tr=0 ts=6a666366 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Aa0Oat_sKGPK8WdvVJkA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_05,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260200

struct drm_simple_display_pipe was meant to simplify simple DRM
drivers, but instead adds an extra wrapper around normal DRM atomic
helper setup. As noted in Documentation/gpu/todo.rst, remaining users
should be converted to regular atomic helpers and stop depending on the
simple-KMS interfaces.

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

Changes are build-tested only. No hardware testing has been performed.

This patch is based on drm-next-2026-06-27.

AI usage disclosure:
- AI tools were also used to review the code and suggest code changes for
  the DRM atomic conversion.

Thanks,
Ze Huang

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
Changes in v3:
- Add a new preparatory patch to avoid duplicate clk_per enables in
  imx-lcdc pipe update after CRTC enable.
- Use commit-local atomic state in enable/update/check paths.
- Link to v2: https://patch.msgid.link/20260716-drm-simple-kms-removal-v2-1-7e4a6b8528e6@oss.qualcomm.com/

Changes in v2:
- use 'commit' as name of struct drm_atomic_commit in atomic helpers
- improve control flow in *_crtc_helper_atomic_check() and
  *_plane_helper_atomic_check()
- Moved page-flip/vblank event handling out of plane update paths and into
  CRTC atomic_flush(), using atomic_flush and disable paths
- decide clock disable by old crtc state
- add calls to drm_crtc_vblank_on() and drm_crtc_vblank_off() in crtc
  atomic_enable() and atomic_disbale()
- test crtc_state->enable before mode size check
- Link to v1: https://patch.msgid.link/20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com

---
Ze Huang (2):
      drm/imx/lcdc: avoid duplicate clk_per enable
      drm/imx: replace struct drm_simple_display_pipe with regular atomic helpers

 drivers/gpu/drm/imx/lcdc/imx-lcdc.c | 263 ++++++++++++++++++++++++++----------
 1 file changed, 190 insertions(+), 73 deletions(-)
---
base-commit: 3696d07837d1df13a5603d77f667685e7dfb3c53
change-id: 20260704-drm-simple-kms-removal-01a031c6a129

Best regards,
-- 
Ze Huang <ze.huang@oss.qualcomm.com>


