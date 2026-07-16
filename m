Return-Path: <linux-aspeed+bounces-4506-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C586C44524
	for <linux-aspeed@archiver.kernel.org>; Sat, 18 Jul 2026 04:31:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h2DPF6BYCz3c6c;
	Sat, 18 Jul 2026 14:31:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784192608;
	cv=none; b=fMfAqT3atNvw8f9Vh7fgm4xxgFIOU8LCamFIKU1rUK/ESvJbHOICZxyh6BUHgs/uHzCs24k28Ktg35ZYNnMI3QZXc1wOIn8z07YL3+D7yqT4Y43FjSg3AQiX/kwTuMy5ky/PhWuP74oC7ZxGb0/agTU9sjIT6Vhqvm8Av8c/ejW4VPgsBYfrxjz88wBxuAUOAyiMQ4M5PU5DLkqm4JtYXGxDF69s8KYsnD7G9PKIuOJPTk4tDyBPiwjjhhg1xtv2cjiH9NLOGUsz78PFTlK3EJnNbse7nJXzQ8qDPkjB7WvcUz2qo015ZzkoGlzOK/1834sJ87uy/eAl+vt41mOeuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784192608; c=relaxed/relaxed;
	bh=MeSqLazRYgr33B487FeWpWmBWUCKqNkEYXob2j87zRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TG8m7GZc6yaS87iVlK7kvcGTophhbVo3aNnnQr8JATWwcKB8tEQqhe0LCK3VRwmdgsixYQHrJYD36CeO2fxFHDvMDleo1EMLassC+9zCRhOrEYO9nVKdfw55R5O6BUnHsbUIlU29wsFwk5D1lA4ITROliJYUz2K5wUzCVoIXBjTlzM9Vp8mPOE24G+4WMq/IWTQbK7FgrZzCxpsKATWFsBQBWi4uB/43k6ArqfncAI8yXrlEM7AtQl0cVN+plnIS0UI6XTg9gzlY8hQOBSl6QHn38nhn5WmXwH93Ba/W8PsqKAQTbLMRPsNt8OVMoJEksVQNygPSthzKiJRY2VZatg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FXVHZpAG; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGEJnEH0; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FXVHZpAG;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RGEJnEH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h16XH3pMtz2xlZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 19:03:26 +1000 (AEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DlQr1734219
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MeSqLazRYgr33B487FeWpWmBWUCKqNkEYXob2j87zRQ=; b=FXVHZpAGJedoRTh8
	n3RpC40OMzwvSPs0hVWwrGEzYyj8qIUe/ElinbQoYVKUsjih/3bJr0JspEfwiHkT
	Hv/bd0/PKRu0B/lwGk43bnVxZ/sfaN/AkKfYjGhdDh+NH6EgBvQXIjRt/ihZNyEW
	CwM7Yw1OwPFp7rmw44bTwGXrmfddtvT/X6D+PRlQHfbk8X18hGykq59dMxKQjHif
	PVH8MGdgMNItGElve/sqSJW2uUH7S6OEIcwfZfDvhvtGQAf2JJynU6mT4tiMyb1U
	/kl3+u71Qlb7J5NdtCaWqSVRb5DG0q0y07ik4skRubojZqf8kd5kJd51wT3oVoKL
	yNwKmQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fed063hhb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 09:03:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c354050c34so106207545ad.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 02:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784192604; x=1784797404; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MeSqLazRYgr33B487FeWpWmBWUCKqNkEYXob2j87zRQ=;
        b=RGEJnEH0d+FAM4Kl6ozrmP+3XhCttRbbszzRM7kk3wfuBk9lrj9eBt/WkPvz3r7RwN
         0L3QAEx3c2r47TqQDRfC6Ls/IEzFt/EtxMBvriAV+B9SIC4Wtj4vWrC+EjsOX/fO7eCp
         Dn8edXfaFW2Bvs2wJ+AWrKr5g6A4P0iY4cgQl173dn2D6062HsK1L4f9WMIiOOz58a9F
         55F057R+8+NdYx90fBeqpDILqKov0bc0MKG+8ImMYJE2PjoaeCQTeHUSmLqlt1QV6D/K
         +WZ2zF91xHn+r3+ifZx++P/mrHDmKDrQNZe9MpMplpMVKDd97QlFRHpTVn2C2xP+0Dox
         6tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784192604; x=1784797404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MeSqLazRYgr33B487FeWpWmBWUCKqNkEYXob2j87zRQ=;
        b=DuuGc76ST5GLj7FodR6qgvK/UvSZ4fYn4ehofyYJ5AG6Bk/7WF5mCpb9zDtjH8fHMW
         sMQ6jhYktVmLd3fpVFe5DfrieACO6HtFP9wsp/tiFULE2INhDIno8Wc+h/plNz06qxI0
         ryD6EMjx73/OFDh0VM8MKZRfMY/oGazlRi4iwmkhPqNiKKJfGH8cnIqFcoSckhzaydhI
         uDtgGdUhUNVo1i8pvajmh/MzEjal/Sd9zrTvT2he/hnOv0jmov91WPABcjRsG2ZS0JMW
         rtqVhUIfsJnmMEvmAvXWtGCJDvwnsEAXP0Mzm1uzdx/w7keJ8O8hmGO+pYO1gLIqpqh1
         L3LQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2CIFSiX9lZa4uquprTxeUmuhiwL5hgHJhns63wnhfFPHFHAMr0HoGUhm0Lj7OjijtzdwV3FKdfr8RQiY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyxmwZbJd8J/EgOYen6VrjHqG7kN/uHyK/r/+8e7G8thfXsfVIL
	DWWnEmhXXuEawh34JvXZmUfj7CSYw7sxjUg8CfAkTjDIIuy6FbxuK+iuyqg4G9SzUF0oAcflxya
	iKp77Kgp7nOVaVxZgNgqsynIreOVFWfuNlncJ7b0FxVwR9r5KukkNFv3dO3ShlN4g5iRS
X-Gm-Gg: AfdE7ckdlvZ/oEAduxsznj8rpCc5znkIP2zdqn9kzOjCD2OjWKjVbHGwhiyw3lzlP6l
	cmdJjI4TF4PvGfaFWQiWUeKzZRXthbd4iWWAikRm0l8Y+oeHiZ1bNd4t71EaYxLOpAcAxD41ftR
	gnXvc17Z25pTfP12xycb1cmp0BIiqf/24kNvfRBqXN1sVX7LS0VHUXpFbMnJjL4Z4ErIJVeWe3O
	qpWW/WMNwSVtMAbhACMBOOHTfZAN/aHpOCS2TGf0/uE3MazF7JPOl2G25HbO6jc79Ty80j2x15Z
	hJKr+EU13FxmP10gzJcbLpJeNZ0YHsqvM/ee+A5Fyf+gvR7L0+UH+gIJNQzd6wGAPY2rjknbM8s
	jsLovGp0Co/6/FIsoN3y+
X-Received: by 2002:a17:902:ecc4:b0:2ca:b8d:e65e with SMTP id d9443c01a7336-2cf03dc62b5mr62673105ad.37.1784192604097;
        Thu, 16 Jul 2026 02:03:24 -0700 (PDT)
X-Received: by 2002:a17:902:ecc4:b0:2ca:b8d:e65e with SMTP id d9443c01a7336-2cf03dc62b5mr62672665ad.37.1784192603523;
        Thu, 16 Jul 2026 02:03:23 -0700 (PDT)
Received: from le-cd01-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm16592555ad.64.2026.07.16.02.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 02:03:23 -0700 (PDT)
From: Ze Huang <ze.huang@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:01:57 +0800
Subject: [PATCH v2 5/8] drm/gm12u320: replace struct
 drm_simple_display_pipe with regular atomic helpers
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
Message-Id: <20260716-drm-simple-kms-removal-v2-5-1133a8fc3785@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784192560; l=7964;
 i=ze.huang@oss.qualcomm.com; s=20260716; h=from:subject:message-id;
 bh=clrd2wPCUImRmnt9dUsqbH/TK0mbxMgUhxeWagkxE+4=;
 b=0oRyaLEkb6eanKq6iqSl6wa+hGMmW3tOf5ZzNUvdnQ1H3jNsbTzi9cLXyJD2dE3oAeyIW6luo
 TPO40xg3wNsAgnlI+cgNB4ljxIOqwV95/AiRUDhwKVkGVCOsCip/o0W
X-Developer-Key: i=ze.huang@oss.qualcomm.com; a=ed25519;
 pk=8uGhlZHInA8NXq7G6u/g59qEcwXwuMRI7nBSnT/ijtY=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfXxTcq6j4NomZf
 pnXwQbyi6Vmc67rMONLl9Z6eOTnikCQEDs47Vz5048pjeY/y5pfpx2JmDbhxgP0MkTo8UNNI1ve
 56cKr9f3VyHZPUjKEq8Qv4bdvuFDXbI=
X-Proofpoint-GUID: 3RafGiq7MkDE0Pkf1IzdTYuXJyhJUtdI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5MSBTYWx0ZWRfX5V7jjlT40ClT
 4LAG1d1mutZ2ZBahj9GJ038nE7tP8E0982kmfmaC4/Lw5pgAjg8T/J/9iAXdavXGQflw8JDt5yc
 0sMYHGZF8ImmAUYNWe4y6lHhkdDGftVWmEOrFNx3amh/3RQCCu3WcC1E6jixD29TlfxLfHuHaDl
 cpFQnxr/vhftpWCQA5d1tQ6OpgXu/JMJ1u7adL/x0xBZU9a/FvGAXNsqf7gO+VZL3OUEeTh3cMx
 Qk+JhBz9AoTIlqPYXzmt7zZBhWLjRa6goDVXiUYJ7vcZFup0AN2641Hu1oXNv3opgWrb8uv1PEC
 8c2TpQP+iWI4H932XKmEG8cam7zUIKkIKgSbjNQxCBUTh70aTIqP8Llti0JdF5Z9f/U63uL2z1w
 UgVX3Y4zXD3rneqWZNU6vH2l1TxTaupVwaERM81ObbnUVGOpM2eyhEhaQhKe2LrTt6c6GI86E29
 I+t0z38EUh/RfTbK10A==
X-Authority-Analysis: v=2.4 cv=Xb25Co55 c=1 sm=1 tr=0 ts=6a589e5c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=g95SU4BBbiomblFqym4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: 3RafGiq7MkDE0Pkf1IzdTYuXJyhJUtdI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160091

Convert gm12u320 to direct primary plane, CRTC and encoder setup.

Keep shadow-plane helper state, framebuffer access helpers and
no-scaling plane-state check from simple-KMS path.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
---
 drivers/gpu/drm/tiny/gm12u320.c | 132 ++++++++++++++++++++++++++++++++--------
 1 file changed, 107 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index d73dfebb4353..df60968856e5 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -8,6 +8,7 @@
 #include <linux/usb.h>
 
 #include <drm/clients/drm_client_setup.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_connector.h>
@@ -27,7 +28,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 static bool eco_mode;
 module_param(eco_mode, bool, 0644);
@@ -87,7 +87,9 @@ MODULE_PARM_DESC(eco_mode, "Turn on Eco mode (less bright, more silent)");
 
 struct gm12u320_device {
 	struct drm_device	         dev;
-	struct drm_simple_display_pipe   pipe;
+	struct drm_plane	         plane;
+	struct drm_crtc		         crtc;
+	struct drm_encoder	         encoder;
 	struct drm_connector	         conn;
 	unsigned char                   *cmd_buf;
 	unsigned char                   *data_buf[GM12U320_BLOCK_COUNT];
@@ -102,7 +104,10 @@ struct gm12u320_device {
 	} fb_update;
 };
 
-#define to_gm12u320(__dev) container_of(__dev, struct gm12u320_device, dev)
+static struct gm12u320_device *to_gm12u320(struct drm_device *__dev)
+{
+	return container_of(__dev, struct gm12u320_device, dev);
+}
 
 static const char cmd_data[CMD_SIZE] = {
 	0x55, 0x53, 0x42, 0x43, 0x00, 0x00, 0x00, 0x00,
@@ -554,43 +559,104 @@ static int gm12u320_conn_init(struct gm12u320_device *gm12u320)
 }
 
 /* ------------------------------------------------------------------ */
-/* gm12u320 (simple) display pipe				      */
+/* gm12u320 display pipe					      */
 
-static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
-				 struct drm_crtc_state *crtc_state,
-				 struct drm_plane_state *plane_state)
+static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+					       struct drm_atomic_commit *commit)
 {
 	struct drm_rect rect = { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
-	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
+	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
+	struct drm_plane_state *plane_state = gm12u320->plane.state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 
 	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
 	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-static void gm12u320_pipe_disable(struct drm_simple_display_pipe *pipe)
+static void gm12u320_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+						struct drm_atomic_commit *commit)
 {
-	struct gm12u320_device *gm12u320 = to_gm12u320(pipe->crtc.dev);
+	struct gm12u320_device *gm12u320 = to_gm12u320(crtc->dev);
 
 	gm12u320_stop_fb_update(gm12u320);
 }
 
-static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *old_state)
+static void gm12u320_plane_helper_atomic_update(struct drm_plane *plane,
+						struct drm_atomic_commit *commit)
 {
-	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(commit, plane);
+	struct drm_plane_state *state = drm_atomic_get_new_plane_state(commit, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_rect rect;
 
+	if (!state->fb)
+		return;
+
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
 		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-static const struct drm_simple_display_pipe_funcs gm12u320_pipe_funcs = {
-	.enable	    = gm12u320_pipe_enable,
-	.disable    = gm12u320_pipe_disable,
-	.update	    = gm12u320_pipe_update,
-	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
+static const struct drm_plane_funcs gm12u320_plane_funcs = {
+	.update_plane	= drm_atomic_helper_update_plane,
+	.disable_plane	= drm_atomic_helper_disable_plane,
+	.destroy	= drm_plane_cleanup,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
+};
+
+static int gm12u320_plane_helper_atomic_check(struct drm_plane *plane,
+					      struct drm_atomic_commit *commit)
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
+static const struct drm_plane_helper_funcs gm12u320_plane_helper_funcs = {
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
+	.atomic_check	= gm12u320_plane_helper_atomic_check,
+	.atomic_update	= gm12u320_plane_helper_atomic_update,
+};
+
+static int gm12u320_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					     struct drm_atomic_commit *commit)
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
+static const struct drm_crtc_helper_funcs gm12u320_crtc_helper_funcs = {
+	.atomic_check	= gm12u320_crtc_helper_atomic_check,
+	.atomic_enable	= gm12u320_crtc_helper_atomic_enable,
+	.atomic_disable	= gm12u320_crtc_helper_atomic_disable,
+};
+
+static const struct drm_crtc_funcs gm12u320_crtc_funcs = {
+	.set_config		= drm_atomic_helper_set_config,
+	.page_flip		= drm_atomic_helper_page_flip,
+	.reset			= drm_atomic_helper_crtc_reset,
+	.destroy		= drm_crtc_cleanup,
+	.atomic_duplicate_state	= drm_atomic_helper_crtc_duplicate_state,
+	.atomic_destroy_state	= drm_atomic_helper_crtc_destroy_state,
+};
+
+static const struct drm_encoder_funcs gm12u320_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
 };
 
 static const uint32_t gm12u320_pipe_formats[] = {
@@ -677,13 +743,29 @@ static int gm12u320_usb_probe(struct usb_interface *interface,
 	if (ret)
 		return ret;
 
-	ret = drm_simple_display_pipe_init(&gm12u320->dev,
-					   &gm12u320->pipe,
-					   &gm12u320_pipe_funcs,
-					   gm12u320_pipe_formats,
-					   ARRAY_SIZE(gm12u320_pipe_formats),
-					   gm12u320_pipe_modifiers,
-					   &gm12u320->conn);
+	ret = drm_universal_plane_init(dev, &gm12u320->plane, 0,
+				       &gm12u320_plane_funcs,
+				       gm12u320_pipe_formats,
+				       ARRAY_SIZE(gm12u320_pipe_formats),
+				       gm12u320_pipe_modifiers,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret)
+		return ret;
+	drm_plane_helper_add(&gm12u320->plane, &gm12u320_plane_helper_funcs);
+
+	ret = drm_crtc_init_with_planes(dev, &gm12u320->crtc, &gm12u320->plane, NULL,
+					&gm12u320_crtc_funcs, NULL);
+	if (ret)
+		return ret;
+	drm_crtc_helper_add(&gm12u320->crtc, &gm12u320_crtc_helper_funcs);
+
+	ret = drm_encoder_init(dev, &gm12u320->encoder, &gm12u320_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret)
+		return ret;
+	gm12u320->encoder.possible_crtcs = drm_crtc_mask(&gm12u320->crtc);
+
+	ret = drm_connector_attach_encoder(&gm12u320->conn, &gm12u320->encoder);
 	if (ret)
 		return ret;
 

-- 
2.43.0


