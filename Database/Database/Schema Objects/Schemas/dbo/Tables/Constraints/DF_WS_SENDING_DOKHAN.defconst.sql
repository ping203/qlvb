﻿ALTER TABLE [dbo].[WS_SENDING]
    ADD CONSTRAINT [DF_WS_SENDING_DOKHAN] DEFAULT ((0)) FOR [DOKHAN];

