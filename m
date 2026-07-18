Return-Path: <linux-aspeed+bounces-4510-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6DDC44512
	for <linux-aspeed@archiver.kernel.org>; Sun, 19 Jul 2026 23:54:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3L8q4bSHz2y8m;
	Mon, 20 Jul 2026 09:54:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784389348;
	cv=none; b=BaX9L/BeWAhv0jHaut27RDXtHFfYRGbKwcUIngF5L9Ux4zjyW6CxF8Gh8izedLxZz4lAQ9mcEMHRVS0Z4Fo8zOsvKaFyRIk7Ad+DKroSqRLHUFcub8QFTYAjeq8aI6wsSg3dwp7mjlqWMCX6+ZIZqu8/8ccXW5LMW/XURIvzNqB6LPxLhGtZwBByPOgkw25j1FLOhMpCUMe4yLptFwLwj0duHIuyPs7xP+i84ea/9rubqZki31G6BwiiemnB2uuyulyBpe4tQuaEaN9P2RZ5GYLrnXBX5jrQca8C4T5DbIJRDXgx2+utKuqu0LdAdjxVr0Sl3GRK59HZ+TfYx3oVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784389348; c=relaxed/relaxed;
	bh=B3Tozc6XvAyXDRXhNm08ssVPc4HklhucZjeYpfFjPmA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cft60qkYVttf4gWZ3FAjjpou1YgzIhjwakIZvDsclUXlgZXt+8WlwNhRpUex8zkD4BR/Z9Ll4h4O8wsFxGn1CYn6bh7POZvxEAj7nOhN/rGQp5r5DHqIRvlk6nPJ/pV+7OZ7u511aaE9pX2Gm6TTwpCE7tvDSsONmabP5mC+caGZ1KiPiQuQ5x2lmoMZ8N2rJYalIa74v/GyRi03/seRR3ll3TyHDNFZQb3KhJ8XtZUl+v7WgKLvtPxT6hKwjipMmB4xSLRH+UQAsedto7suNxaJTO6SFv0o8JMR86YRtezvh1TMHYDCGdPM1V0KtE138bS0xOmf5BfncgmNyv8nPw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l9F6S0Gn; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uyv0wJQt; dkim-atps=neutral; spf=pass (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=l9F6S0Gn;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Uyv0wJQt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.168.131; helo=mx0a-0031df01.pphosted.com; envelope-from=ze.huang@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h2WHk2TGSz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Sun, 19 Jul 2026 01:42:24 +1000 (AEST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66IDDcCt1853435
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Jul 2026 15:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B3Tozc6XvAyXDRXhNm08ssVPc4HklhucZjeYpfFjPmA=; b=l9F6S0Gnb2vjgD6a
	NBQfReSJBOyCIXwIUgjQE9ha1CjdNnqVi17UErZCTYSlBRo/TxMbCbjqKp2d0Yy8
	2grbSegaeCpYWBsCtdZz1Mn3v8FEv1j5UcVICfCZoIiXa6CDvpkRuAbnTODcJZ/U
	B2BcXlqo9x1yKCfP3m63lMsLAwNF6umECQ3O2BYkakRH9Y3pltrWALui4/z2ZZDB
	Oohi70BkTEVI9LYX4Az4ZXFHWOAsSgFmcQVj/yBR+bc/KWRawPM7IARiYuzeczGl
	2Z7prJm/hdBFhaSSwCdQjPyC6p/fQJ948P1wqkX9Tl6bHTlDilZ5bfpKV/jZ9sV8
	GzU+Jw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aas2n6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Jul 2026 15:42:20 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so4296948a12.0
        for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Jul 2026 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784389339; x=1784994139; darn=lists.ozlabs.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B3Tozc6XvAyXDRXhNm08ssVPc4HklhucZjeYpfFjPmA=;
        b=Uyv0wJQtSebkUstf4e+G5hoMuAQCvFlSIR8Gq4Honc9Hugk2s8u8BWbiuw1XomEKG8
         uPwPwgudqAMWXoLaU0XcgGUwHISFu7m9FT1uKlZnD58UZZjb6vTTHrCsLACmGpIGp3tX
         OaAaUMcPiX9VLH0j8gXXOInrQr49Q9zMuM6EaSFmUyrREyzoYXsf6fKTqC1MiPbqZd0u
         ajss+1/PnwR3DDLYtaJFdZHlrYV8SgTuAYikU5baDzye1LQlS9sF6o1LrzseK3qUO/WK
         wNGu499gM08mJY7PAFNLLXdKyazsACHN5pRV0KIh+GJjZOd3yz4nltSjSwxx2n6HaILT
         CflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784389339; x=1784994139;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B3Tozc6XvAyXDRXhNm08ssVPc4HklhucZjeYpfFjPmA=;
        b=fIkNiTCpe18niZFG83HjtunQeFbDcd+52qr4cI+id6DY8BVqQF2ynNIEJgaziExcVS
         VmsMgvHARSLHEmWT/MgfW/7cUH1TmM7VluqVjQGb5qiQIIyQkANTBkSiNTZkmQ8A5cSR
         U/fDsw4va4z39buETjVB1kSVDSOdgbyZUkCKOnAFtmEdN9xpUArkN5K+EnMmN/LPe8XO
         fjKJ/frAW8azZNeegJ82h09PoXBI3l7in52cwp6zwlFC5b/OepUtzbRVdlTsk6v/Jh8d
         LmxJlIQ+3sDTKLnphMFOGvG4VNsBP0HwCKKEJ7uhy2GlIxFDfhhRGBD+syEa8ctsfLhJ
         QhaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsFWux0gZlyh1yLqjDJWIGXDewaQGxwor1uNpDz1+mTJpz3g8tR2O5vr0O0r1tKl8WneClvw93b3bTweE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxw5VFeqH8i5wW2+RpcvYMaGdGOOmnHJclQ9OBAGMk+9uwkZp8e
	x7ZyX3U95Zb0hrwDhG4Faww5Q7iFIpt8JhwHNbeRv8C5dI3EtHYDUS6H/f2WXSE3TQVnpsxprPS
	fZOPwZFt5LUdlRBLndN274pb1OIH79ycnxPumcxOfSRJ9lM95ft1ivAi3Y3JdR8+3ezj0
X-Gm-Gg: AfdE7clOF71BWYP0fBtxCuOY0GvmyI91zalyU/Am9EFb4ZyfFSfj/7Yv1XzHPydE/2z
	9gwJkGX1rmd7wcjjdHF8scSdK/ItEU85eIg+PBb2p6oRG1GKL46cIYOim9gI8RIv1vVoheuYjRa
	dSHVAp+DanX4VGGeJxzIDsNSOCJxCvoKn+CAxDWEcZthfr+yCXKKRrrQteKQpwQE2mOXLztmyvd
	6aOupqswYgr7E8wERANvFlnknv0JAUeipbEpsiTg92uAfcDRVxOi5tMmDSL3zxpCFBlwdVk124f
	7r9X+Tj0fbiglC6nitrKyI1Fqx5r6WXsq9HImww2JDzcSQHzWD1tC2U68HgT61uJEUkPlRJk3Hc
	d9SI0ZQ==
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id adf61e73a8af0-3c3ad9717d4mr7925886637.40.1784389339433;
        Sat, 18 Jul 2026 08:42:19 -0700 (PDT)
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id adf61e73a8af0-3c3ad9717d4mr7925851637.40.1784389338852;
        Sat, 18 Jul 2026 08:42:18 -0700 (PDT)
Received: from localhost ([188.253.117.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9d439sm22974922eec.5.2026.07.18.08.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 08:42:18 -0700 (PDT)
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 23:42:10 +0800
Message-Id: <DK1T85P7OAAY.RXCY4AX71VRX@oss.qualcomm.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>, <imx@lists.linux.dev>,
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 5/8] drm/gm12u320: replace struct
 drm_simple_display_pipe with regular atomic helpers
From: "Ze Huang" <ze.huang@oss.qualcomm.com>
To: "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Ze Huang"
 <ze.huang@oss.qualcomm.com>,
        "Alexey Brodkin" <abrodkin@synopsys.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard"
 <mripard@kernel.org>,
        "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>,
        "Joel Stanley" <joel@jms.id.au>,
        "Andrew Jeffery"
 <andrew@codeconstruct.com.au>,
        "Frank Li" <Frank.Li@nxp.com>,
        "Sascha
 Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team"
 <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Linus
 Walleij" <linusw@kernel.org>,
        "Hans de Goede" <hansg@kernel.org>,
        "Alex
 Lanzano" <lanzano.alex@gmail.com>,
        "Oleksandr Andrushchenko"
 <oleksandr_andrushchenko@epam.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com> <20260716-drm-simple-kms-removal-v2-5-1133a8fc3785@oss.qualcomm.com> <26981ae1-4aef-4965-8600-f5e30a1b564a@suse.de>
In-Reply-To: <26981ae1-4aef-4965-8600-f5e30a1b564a@suse.de>
X-Proofpoint-GUID: PrHOdzQYmtvF6z5dtJPHrjleYjMiChbC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDE2MyBTYWx0ZWRfXxYe2PLTUDDeK
 kjNdNkte+LKZb9CBxxFHvbHV+cS+DnjFve90B7eY/hwoAH/FIFv5ZxnwoSh92lGtOVxdB3KVgUE
 cY/FvW6GRDns61a+1uQSCk8lZtLf4Ec=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5b9edc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=RQ3dwY0XcLBFaqRX7rIGyg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ZBS7nKAnUslcPLfxFb0A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: PrHOdzQYmtvF6z5dtJPHrjleYjMiChbC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDE2MyBTYWx0ZWRfX95wJM6FUvPqc
 DltrO3DvIK62vLy+Jcdgr7USwX1+JDrZGzZYKTG//g8vPc9k8ginGAyj5/B2c89rx1zORP25OXN
 Pn01K+mkNBCmibNIlLZ8Jw25JwFByNcO1sYlTZDIMJNRPGzSnc621su9AreecJuAypTm7nwIh4G
 x7NAqV+BNi01ArHUNT0YzAmt4Wf2rDmSyO7Q5YBN+V37xGZ5WT5r3FMUMv21oIcmSEwest/hAsf
 FHnShsrjb6ROtOyyk9tiK7Lwc+dDPqpU3M9Km3B5Jl64zetY4kQ0KPBUaaKmy7fWI3oemRzKK9U
 vUz1Go5fC8FHChM10Y8rbQZxfDGONZab5TWkttXgXbqkxz39MqEzpd8Jv6+PgooK7AF0osWwpuo
 v9ev3gFIJDHZFH5IiFlqVKYXfTpl0ywBoWXEDz1PSoCXfVQ/8Vrl3dsaBzuxAOWYFZUQVGT0c/O
 +HRW/Ah6NZTI2Afoylw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607180163

On Fri Jul 17, 2026 at 3:18 PM CST, Thomas Zimmermann wrote:
> Hi
>
> Am 16.07.26 um 11:01 schrieb Ze Huang:
>> Convert gm12u320 to direct primary plane, CRTC and encoder setup.
>>
>> Keep shadow-plane helper state, framebuffer access helpers and
>> no-scaling plane-state check from simple-KMS path.
>>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Signed-off-by: Ze Huang <ze.huang@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/tiny/gm12u320.c | 132 ++++++++++++++++++++++++++++++++=
--------
>>   1 file changed, 107 insertions(+), 25 deletions(-)
>>
> [...]
>>  =20
>> -static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
>> -				 struct drm_crtc_state *crtc_state,
>> -				 struct drm_plane_state *plane_state)
>> +static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>> +					       struct drm_atomic_commit *commit)
>>   {
>>   	struct drm_rect rect =3D { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT=
 };
>> -	struct gm12u320_device *gm12u320 =3D to_gm12u320(pipe->crtc.dev);
>> +	struct gm12u320_device *gm12u320 =3D to_gm12u320(crtc->dev);
>> +	struct drm_plane_state *plane_state =3D gm12u320->plane.state;
>
> Did you see the reply from the Sashiko bot?
>
> What happens is that user space can apply multiple atomic commits in a=20
> row, but they are applied to hardware asynchronously. So if you take the=
=20
> plane state here directly from the plane, it could have been replaced by=
=20
> a later atomic commit already.=C2=A0 Rather get the correct plane state w=
ith=20
> the helper drm_atomic_get_new_plane_state().
>

I think I misunderstood this point. I had assumed that
drm_atomic_get_*_state() was only needed for the state object directly
matching the helper callback, for example crtc_state in
*_crtc_helper_atomic_enable() and plane_state in
*_plane_helper_atomic_update(), while other state could be accessed via
the device-private structure.

From your explanation, I see that this is wrong. In the atomic commit
path, any state associated with the current commit should be obtained
through drm_atomic_get_*_state(), because the object=E2=80=99s ->state may
already refer to a later commit.

> I did not look at all of the series' patches for this problem, but the ru=
le
> applies to all of the mode-setting code.
>
> Best regards
> Thomas

This affects other patches in the series as well, and some drivers may
need additional fixes in internal helpers too, e.g. arc_pgu_set_pxl_fmt()
in arcpgu.c [1].

I will audit the full series and fix such cases in the next version.

Best regards
Ze

