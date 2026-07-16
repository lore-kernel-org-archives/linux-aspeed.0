Return-Path: <linux-aspeed+bounces-4497-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829C0C4451C
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:31:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DP73TTnz3c78;
	Sat, 18 Jul 2026 14:31:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784192586;
	cv=none; b=V+mn32f5npz5ul+FdeQQxD3XOJWjCqPPR1kYp+T/ovElp7KDU9xcteO7I9RcoHSfyXifpqlxe0MPpZu47H4gb7qvP9libZjorWo8EE55/Yhzy9h5a3OnyQpo6RtzHygeUQdcz6ujmwgR76PEMpIBjWH2PtaTNWsT8XdXON9+1lC14pPm3ObjGOEXkAdgUb+Zcd6YyS95XOPB8DVCwLl3ZMvNyBY/PU/cnDMWhpZr3k/GsD1NWu1xkdwtVJ3jXicYD+mW7MNOeW0g4Na+OFGwIBTD0Zoa6l/mKFQA4ba0VVV3fF0YxAZQhX/tDpkZgX6AmF5rGb89Es2WiP6G7o3wGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784192586; c=relaxed/relaxed;
	bh=3tiM2Xo9zA0AwLl933KbtXA0+pjiqMOmFkNsBFhqzo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aUXkzQFEdZdDtKdEz8/zaCGI0gULf93nO86ZNOxGuJtmM76J3MhV18LzlvbDyTJOj1AFC/BAXFnQR//wYLf4P9fA1mGvpaEXwrxwrA67jQqkHKWdi2jRA8Sal6dXWZBEP0s58KNeORwQlzGswMzGq3NkQoiHapoEhGqyhCccAumMwYnMKaIDe24Kyp2ZBQ25+/tiOJ5+a6vFqOH9uK+8UfPvNsgOyc8Sryisjc4jlY/Ru7tracRyERGwujzzjm8O6nKgEVsH+mZUdPA1gIlNcP8wXJ/T0jbt6X/lWqUAZib95/BO+/9QsNmzlxpen5DefsPdfkFWS1bLj9gHRxgzzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9/7xKQf; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=budVRT/3; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O9/7xKQf;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=budVRT/3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h16Wt0mDlz2xlZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 19:03:05 +1000 (AEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G837LQ2123247
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3tiM2Xo9zA0AwLl933KbtXA0+pjiqMOmFkNsBFhqzo8=; b=O9/7xKQfaUdPOLcf
	47Wc9WqOJhDcpZvw6ig8VgPVsE02760Kn1LAnh+w7W5tbwEELiqdLkw41ky4ReK9
	+uPEd0WSzdJqM15s6LaHy27C86zf4WgmqlM9+t+trH8TYGHkUcXZ7hOKUZ29Z7QH
	uKAO5Wsxn/5mz9Sz9cotDVDKJT55oLN9N43wbKPH0QU4LdtdNRhLhHULxOdWBquE
	l57XJ4pJpFkq/Mpob8bIz2vfeD9qfkQIJOQVU/g3uYx5LuTcgwIdRCYO2q9a9M/c
	ugxJveHf6VpSJutCvcgMNTumSBTld04Nb4W5naMOVwDZh6VEw64auKdmcxvhpUuD
	k809pg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex073j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cacf17c7e0so46089525ad.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784192583; x=1784797383; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3tiM2Xo9zA0AwLl933KbtXA0+pjiqMOmFkNsBFhqzo8=;
        b=budVRT/3jTvfiRWY+8iFkN6RB3+2WHvOyBIVLhLPSUs9ANy1VaOrm5wVPmUn9rLPj0
         Sq278my0SGvy12cFNug+To2wMZLZuy36f69t7gzgAtMbM4/hnaK0061wtsTl4VfD9aOi
         +hDUMQsb8iRW6Knz9vbczg0qiKiS08Vt2gqBEMdwLj8B5qX0Z/B7wo3W0hcMjZk6ty8e
         WtwPl17xI3xeeQTDB8yyRxla15fLZuqNXHR3ndFQeKuKJacuSVm0X9Vzqeidn5CUEZEd
         a6dLm/Sw0xumgB0Imh0lGC6McV4ytbZd0yPk3oJAqkEE3qakwXDpEGZ6ezcQVmInp5Zy
         4cLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192583; x=1784797383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tiM2Xo9zA0AwLl933KbtXA0+pjiqMOmFkNsBFhqzo8=;
        b=SR+GYhzIz4j6v8mswz3cpIRpfWSdjgp6Hc3ZIt1EVHrq3Djj2lGYSjffcOgSulWKge
         512+aGk9TZ40vKbyz0jXx+aC3Asv7i2U9g3M7tSAi4d0/cZxgkJBIMLcwVZHYU8kEatk
         DMSib0S2sRp6Sv1qbW9pv4uw/3YXlIWCavWtmyxHhpf+Mn0IqRc/3xt027FJd+hHVDW8
         mYsHV3z3eH0ydGh1SwRmNHQFeS90oIxjnnqnTDZEkXurwrrqBhB5c50uwiwX3afIp8HE
         RJP+lfIE4qd9/ok7wGvI/YctthAElrxxUiwhq7j+2XpogeBJU791Cqf8eM5PO01q6Okg
         rbKw==
X-Forwarded-Encrypted: i=1; AHgh+RrL+I28Kaeyk/mDJiAplK02GsMZg/tT95c2DwWRKH2mG+iSABxbTzEC1/Pye8xnEapkTzeNpdF+lYkKSmw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPB0O/hikToQoZCRdDr4vxf3uvZblh5OX6sv+U8WvJn5saycXr
	kDDTmcNHRG8P+sTqlH2HUfn/NBJRV4ox2QwP/HgPwGgmJrKHGLKy9XOm/eGMcPG/Iac3hvp8gPN
	MLLl9Cd92/hGXdOVhN/Nsoxupx0Z5Z3+JLIt1EjVRl+JKZCViwXkBsW8//KKiRK3reQoV
X-Gm-Gg: AfdE7cmkiWe0iP24QNMSjhL/BVqbYTvubVp0LEmkVTxygc9ol8Ygulv/PlvyRObIvTy
	oKuxmcmqcc78LFisVZTDMlfI3BIACAR4mk5t6aSPQZDVTrvcovby/83igj/wLR5cs3sC5b2xlCP
	5AEqU6q1jWkSBe8TKrHzbPubkJfQFvDjqFht2CLhc2Vf3u1GL2XhLruZAlHKfZvyStwSk1ns57m
	afU8Dfl/H26Tb+8LZRQqe1PhkfzptyDBa/++xRxss1URPPR5wHG0kmMg7UH6eBnDHOOxmjuj9MC
	GQj2BflpnVDTJxno7OlLKwhi4haHWeeFAIpLaWfn/ZXZNM5Qhf0XOKV7jHtU7dJJXOOOcl55lCV
	xQwtq/CiUNRDmWQ2FW15h
X-Received: by 2002:a17:902:f607:b0:2cc:ed57:c7c with SMTP id d9443c01a7336-2ce9f02700cmr212712135ad.32.1784192582507;
        Thu, 16 Jul 2026 02:03:02 -0700 (PDT)
X-Received: by 2002:a17:902:f607:b0:2cc:ed57:c7c with SMTP id d9443c01a7336-2ce9f02700cmr212711795ad.32.1784192582033;
        Thu, 16 Jul 2026 02:03:02 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:03:01 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:01:54 +0800
Subject: [PATCH v2 2/8] drm/aspeed: replace struct drm_simple_display_pipe
 with regular atomic helpers
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
Message-Id: <20260716-drm-simple-kms-removal-v2-2-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
In-Reply-To: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192559; l=12008;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=rgxLNMtjqM2teYTKXy4V5myTjAOMrw9ADBn88PQUgl0=;
 b=ao1ZOxz4FyLpOnjIgILtb38iIdAixsALUtxQDG2VQUbz8T8Og34pyHoZwIWje5N1T6AYfjR5S
 qn1GtR7rJPWCqaq+yohY4PFirxldOeXdvRZrYuYSVbXv6647oU82tUe
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a589e47 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=DqWk4Bt2HhJbFETiZXkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: 0QUqPufdjr0bvwzpUb-g2Mmrj0o31MEN
X-Proofpoint-GUID: 0QUqPufdjr0bvwzpUb-g2Mmrj0o31MEN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX/IrJ1wmTn3h3
 xUIDBHlSafIpKksWGOVyvmPhi8vOCHYpYTIOR1cdZOQoWOScN++CzMY7awYO+WH/FqHuta1gnvG
 wSij3RUXbMaU+UU6WTg4q/rB1ElpYQY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfXzqZFpqHofp/8
 46sYz/x4hrZqk3S2vd4vY8QRMUjOXIjDaAovG57SuhCw43h5GUQswnAvjmVeoN0zOQIZGMPlVtP
 QKZm4z21Nfz6mH9yLO4JM85Xw7502gzQSJ4HtAJYxrKKB0MkKEW799wrZfDTCFO7OfzHvEjaeE+
 rhjQVG0IPhyBYxXt2iZmGUcM5N7697FpX6MQQw/6PQBSX5bRQTb+vNmEkJHOAB7CpY0p/x7/pdu
 MsjFUBw+k4TX1WcQ2JPWOEIHrcetSCP1LOQIAMxXjJm0/mXGe9vrr+Gng1qh5JRuppH7EcQZkWo
 cxwh1ae7K2gp115jAEN5eey/J6lsOlHAWtAzN0TD6+2uhyYoiH8+JA5BTiiD1Dt5q9nnaJCEtYm
 kbG5moRLKDGSzNU3N69MmifyNoYtP1FFdslBmlOjAILTBeuJcL/7ZBlm5mczf3MO6DM4+O1T5lK
 BVdjsy2w7++ou4JqEpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091

Replace simple display pipe with explicit plane, CRTC and encoder
objects. Move callbacks to plane and CRTC helpers, with vblank handling
through drm_crtc_funcs.

Move page-flip event handling out of the plane update path and into the
CRTC atomic flush path.

Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx.h      |  11 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 187 ++++++++++++++++++++++---------
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |   3 +-
 3 files changed, 145 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index 4e6a442c3886..61588f4273a0 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -2,7 +2,6 @@
 /* Copyright 2018 IBM Corporation */
 
 #include <drm/drm_device.h>
-#include <drm/drm_simple_kms_helper.h>
 
 struct aspeed_gfx {
 	struct drm_device		drm;
@@ -17,10 +16,16 @@ struct aspeed_gfx {
 	u32				throd_val;
 	u32				scan_line_max;
 
-	struct drm_simple_display_pipe	pipe;
+	struct drm_plane		plane;
+	struct drm_crtc			crtc;
+	struct drm_encoder		encoder;
 	struct drm_connector		connector;
 };
-#define to_aspeed_gfx(x) container_of(x, struct aspeed_gfx, drm)
+
+static struct aspeed_gfx *to_aspeed_gfx(struct drm_device *drm)
+{
+	return container_of(drm, struct aspeed_gfx, drm);
+}
 
 int aspeed_gfx_create_pipe(struct drm_device *drm);
 int aspeed_gfx_create_output(struct drm_device *drm);
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
index 7877a57b8e26..5946af36cc69 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
@@ -5,6 +5,8 @@
 #include <linux/reset.h>
 #include <linux/regmap.h>
 
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_device.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
@@ -12,22 +14,15 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_panel.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "aspeed_gfx.h"
 
-static struct aspeed_gfx *
-drm_pipe_to_aspeed_gfx(struct drm_simple_display_pipe *pipe)
-{
-	return container_of(pipe, struct aspeed_gfx, pipe);
-}
-
 static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32 *bpp)
 {
-	struct drm_crtc *crtc = &priv->pipe.crtc;
+	struct drm_crtc *crtc = &priv->crtc;
 	struct drm_device *drm = crtc->dev;
-	const u32 format = crtc->primary->state->fb->format->format;
+	const u32 format = priv->plane.state->fb->format->format;
 	u32 ctrl1;
 
 	ctrl1 = readl(priv->base + CRT_CTRL1);
@@ -79,7 +74,7 @@ static void aspeed_gfx_disable_controller(struct aspeed_gfx *priv)
 
 static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
 {
-	struct drm_display_mode *m = &priv->pipe.crtc.state->adjusted_mode;
+	struct drm_display_mode *m = &priv->crtc.state->adjusted_mode;
 	u32 ctrl1, d_offset, t_count, bpp;
 	int err;
 
@@ -139,48 +134,33 @@ static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
 	writel(priv->throd_val, priv->base + CRT_THROD);
 }
 
-static void aspeed_gfx_pipe_enable(struct drm_simple_display_pipe *pipe,
-			      struct drm_crtc_state *crtc_state,
-			      struct drm_plane_state *plane_state)
+static void aspeed_gfx_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+						 struct drm_atomic_commit *commit)
 {
-	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
-	struct drm_crtc *crtc = &pipe->crtc;
+	struct aspeed_gfx *priv = to_aspeed_gfx(crtc->dev);
 
 	aspeed_gfx_crtc_mode_set_nofb(priv);
 	aspeed_gfx_enable_controller(priv);
 	drm_crtc_vblank_on(crtc);
 }
 
-static void aspeed_gfx_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void aspeed_gfx_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+						  struct drm_atomic_commit *commit)
 {
-	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
-	struct drm_crtc *crtc = &pipe->crtc;
+	struct aspeed_gfx *priv = to_aspeed_gfx(crtc->dev);
 
 	drm_crtc_vblank_off(crtc);
 	aspeed_gfx_disable_controller(priv);
 }
 
-static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
-				   struct drm_plane_state *plane_state)
+static void aspeed_gfx_plane_helper_atomic_update(struct drm_plane *plane,
+						  struct drm_atomic_commit *commit)
 {
-	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
-	struct drm_crtc *crtc = &pipe->crtc;
-	struct drm_framebuffer *fb = pipe->plane.state->fb;
-	struct drm_pending_vblank_event *event;
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(commit, plane);
+	struct aspeed_gfx *priv = to_aspeed_gfx(plane->dev);
+	struct drm_framebuffer *fb = new_plane_state->fb;
 	struct drm_gem_dma_object *gem;
 
-	spin_lock_irq(&crtc->dev->event_lock);
-	event = crtc->state->event;
-	if (event) {
-		crtc->state->event = NULL;
-
-		if (drm_crtc_vblank_get(crtc) == 0)
-			drm_crtc_arm_vblank_event(crtc, event);
-		else
-			drm_crtc_send_vblank_event(crtc, event);
-	}
-	spin_unlock_irq(&crtc->dev->event_lock);
-
 	if (!fb)
 		return;
 
@@ -190,9 +170,9 @@ static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
 	writel(gem->dma_addr, priv->base + CRT_ADDR);
 }
 
-static int aspeed_gfx_enable_vblank(struct drm_simple_display_pipe *pipe)
+static int aspeed_gfx_crtc_enable_vblank(struct drm_crtc *crtc)
 {
-	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
+	struct aspeed_gfx *priv = to_aspeed_gfx(crtc->dev);
 	u32 reg = readl(priv->base + CRT_CTRL1);
 
 	/* Clear pending VBLANK IRQ */
@@ -204,9 +184,9 @@ static int aspeed_gfx_enable_vblank(struct drm_simple_display_pipe *pipe)
 	return 0;
 }
 
-static void aspeed_gfx_disable_vblank(struct drm_simple_display_pipe *pipe)
+static void aspeed_gfx_crtc_disable_vblank(struct drm_crtc *crtc)
 {
-	struct aspeed_gfx *priv = drm_pipe_to_aspeed_gfx(pipe);
+	struct aspeed_gfx *priv = to_aspeed_gfx(crtc->dev);
 	u32 reg = readl(priv->base + CRT_CTRL1);
 
 	reg &= ~CRT_CTRL_VERTICAL_INTR_EN;
@@ -216,12 +196,91 @@ static void aspeed_gfx_disable_vblank(struct drm_simple_display_pipe *pipe)
 	writel(reg | CRT_CTRL_VERTICAL_INTR_STS, priv->base + CRT_CTRL1);
 }
 
-static const struct drm_simple_display_pipe_funcs aspeed_gfx_funcs = {
-	.enable		= aspeed_gfx_pipe_enable,
-	.disable	= aspeed_gfx_pipe_disable,
-	.update		= aspeed_gfx_pipe_update,
-	.enable_vblank	= aspeed_gfx_enable_vblank,
-	.disable_vblank	= aspeed_gfx_disable_vblank,
+static int aspeed_gfx_plane_helper_atomic_check(struct drm_plane *plane,
+						struct drm_atomic_commit *commit)
+{
+	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(commit, plane);
+	struct drm_crtc *crtc = plane_state->crtc;
+	struct drm_crtc_state *crtc_state = NULL;
+
+	if (crtc)
+		crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+
+	return drm_atomic_helper_check_plane_state(plane_state, crtc_state,
+						   DRM_PLANE_NO_SCALING,
+						   DRM_PLANE_NO_SCALING,
+						   false, false);
+}
+
+static const struct drm_plane_helper_funcs aspeed_gfx_plane_helper_funcs = {
+	.prepare_fb	= drm_gem_plane_helper_prepare_fb,
+	.atomic_check	= aspeed_gfx_plane_helper_atomic_check,
+	.atomic_update	= aspeed_gfx_plane_helper_atomic_update,
+};
+
+static const struct drm_plane_funcs aspeed_gfx_plane_funcs = {
+	.update_plane		= drm_atomic_helper_update_plane,
+	.disable_plane		= drm_atomic_helper_disable_plane,
+	.destroy		= drm_plane_cleanup,
+	.reset			= drm_atomic_helper_plane_reset,
+	.atomic_duplicate_state	= drm_atomic_helper_plane_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
+};
+
+static int aspeed_gfx_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	int ret;
+
+	if (crtc_state->enable) {
+		ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+		if (ret)
+			return ret;
+	}
+
+	return drm_atomic_add_affected_planes(commit, crtc);
+}
+
+static void aspeed_gfx_crtc_helper_atomic_flush(struct drm_crtc *crtc,
+						struct drm_atomic_commit *commit)
+{
+	struct drm_crtc_state *new_crtc_state = drm_atomic_get_new_crtc_state(commit, crtc);
+	struct drm_pending_vblank_event *event = new_crtc_state->event;
+
+	if (!event)
+		return;
+
+	new_crtc_state->event = NULL;
+
+	spin_lock_irq(&crtc->dev->event_lock);
+	if (drm_crtc_vblank_get(crtc) == 0)
+		drm_crtc_arm_vblank_event(crtc, event);
+	else
+		drm_crtc_send_vblank_event(crtc, event);
+	spin_unlock_irq(&crtc->dev->event_lock);
+}
+
+static const struct drm_crtc_helper_funcs aspeed_gfx_crtc_helper_funcs = {
+	.atomic_check	= aspeed_gfx_crtc_helper_atomic_check,
+	.atomic_enable	= aspeed_gfx_crtc_helper_atomic_enable,
+	.atomic_disable	= aspeed_gfx_crtc_helper_atomic_disable,
+	.atomic_flush	= aspeed_gfx_crtc_helper_atomic_flush,
+};
+
+static const struct drm_crtc_funcs aspeed_gfx_crtc_funcs = {
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+	.enable_vblank		= aspeed_gfx_crtc_enable_vblank,
+	.disable_vblank		= aspeed_gfx_crtc_disable_vblank,
+};
+
+static const struct drm_encoder_funcs aspeed_gfx_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static const uint32_t aspeed_gfx_formats[] = {
@@ -232,10 +291,36 @@ static const uint32_t aspeed_gfx_formats[] = {
 int aspeed_gfx_create_pipe(struct drm_device *drm)
 {
 	struct aspeed_gfx *priv = to_aspeed_gfx(drm);
+	struct drm_plane *plane = &priv->plane;
+	struct drm_crtc *crtc = &priv->crtc;
+	struct drm_encoder *encoder = &priv->encoder;
+	int ret;
+
+	ret = drm_universal_plane_init(drm, plane, 0,
+				       &aspeed_gfx_plane_funcs,
+				       aspeed_gfx_formats,
+				       ARRAY_SIZE(aspeed_gfx_formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(plane, &aspeed_gfx_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(drm, crtc, plane, NULL,
+					&aspeed_gfx_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(crtc, &aspeed_gfx_crtc_helper_funcs);
+
+	ret = drm_encoder_init(drm, encoder, &aspeed_gfx_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
+
+	ret = drm_connector_attach_encoder(&priv->connector, encoder);
+	if (ret)
+		return ret;
 
-	return drm_simple_display_pipe_init(drm, &priv->pipe, &aspeed_gfx_funcs,
-					    aspeed_gfx_formats,
-					    ARRAY_SIZE(aspeed_gfx_formats),
-					    NULL,
-					    &priv->connector);
+	return 0;
 }
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 46094cca2974..b2d805f0c16d 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -21,7 +21,6 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_module.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_drv.h>
 
@@ -130,7 +129,7 @@ static irqreturn_t aspeed_gfx_irq_handler(int irq, void *data)
 	reg = readl(priv->base + CRT_CTRL1);
 
 	if (reg & CRT_CTRL_VERTICAL_INTR_STS) {
-		drm_crtc_handle_vblank(&priv->pipe.crtc);
+		drm_crtc_handle_vblank(&priv->crtc);
 		writel(reg, priv->base + priv->int_clr_reg);
 		return IRQ_HANDLED;
 	}

-- 
2.43.0


