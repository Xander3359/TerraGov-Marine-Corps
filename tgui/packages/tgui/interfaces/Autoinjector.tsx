import { BooleanLike } from 'common/react';

import { useBackend } from '../backend';
import { Box, Button } from '../components';
import { Window } from '../layouts';

type Data = {
  InjectMode: BooleanLike;
  CurrentLabel: string;
  CurrentTag: string;
  TransferAmount: number;
};

export const Autoinjector = (props) => {
  const { act, data } = useBackend<Data>();
  const { InjectMode, CurrentLabel, CurrentTag, TransferAmount } = data;
  return (
    <Window width={300} height={375}>
      <Box>
        <Button m={2} onClick={() => act('ActivateAutolabeler')}>
          Activate Autolabeler
        </Button>
        <Box ml={2}>
          <b>Current label: </b>
          {CurrentLabel}
        </Box>
        <Button m={2} onClick={() => act('ActivateTagger')}>
          ActivateTagger
        </Button>
        <Box ml={2}>
          <b>Current tag: </b>
          {CurrentTag}
        </Box>
        <Button m={2} onClick={() => act('ToggleMode')}>
          Toggle Mode
        </Button>
        <Box ml={2}>
          <b>Current mode: </b>
          {InjectMode ? 'Injecting' : 'Drawing'}
        </Box>
        <Button m={2} onClick={() => act('SetTransferAmount')}>
          Set Transfer Amount
        </Button>
        <Box ml={2}>
          <b>Current transfer amount: </b>
          {TransferAmount}
        </Box>
        <Button color={'red'} m={2} onClick={() => act('EmptyHypospray')}>
          Empty Hypospray
        </Button>
      </Box>
    </Window>
  );
};
